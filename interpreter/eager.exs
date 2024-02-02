defmodule Eager do
  import Listmap
  import Prgm
  ### Explanations in the task pdf was not great so this is more of a combination of following those instrctuctions
  ### and reading the code for clarifications. New standard for type, variable and function names will be to
  ### NOT shorten them in order to increase clarity
  @doc """
  Boilerplate documentation example
  """
  # @type example_type :: {:structure, example} | example_type2
  # @spec example_function(input_type1, input_type2) :: output1 | output2
  # Custom types
  @type atm :: {:atm, atom()}
  @type variable :: {:var, atom()}
  @type ignore :: :ignore
  @type cons(t) :: {:cons, t, t}
  @type match :: {:match, pattern, expression}
  @type pattern :: atm | variable | ignore | cons(pattern)
  @type expression :: atm | variable | cons(expression) | apply | case
  @type sequence :: [expression] | [match | sequence]
  @type strct :: atom | [strct]
  @type environment :: [{atom, strct}]
  @type case :: {:case, expression, [clause]}
  @type clause :: {:clause, pattern, sequence}
  @type lambda :: {:lambda, [atom], [atom], sequence}
  @type closure :: {:closure, [atom], sequence, environment}
  @type apply :: {:apply, expression, [expression]}


  @doc """
  Called from the outside, given a sequence of expressions with a return of a struct containing the completed
  evaluation or error
  """
  @spec evaluate(sequence) :: {:ok, strct} | :fail
  def evaluate sequence do
    evaluate_sequence(sequence, new())
  end

  @doc """
  Evaluates a set of sequences AKA you give in statements + an environment and you get the values that are returned
  """
  @spec evaluate_sequence(sequence, environment) :: {:ok, strct} | :error
  def evaluate_sequence [{:match, pattern, expression} | sequence], environment do
    case evaluate_expression(expression, environment) do
      {:ok, strct} ->
        environment = evaluate_scope(pattern, environment)
        case evaluate_match(pattern, strct, environment) do
          {:ok, environment} ->
            evaluate_sequence(sequence, environment)
          :fail ->
            :error
        end
      :fail ->
        :error
    end
  end
  def evaluate_sequence [expression], environment do
    evaluate_expression(expression, environment)
  end
  def evaluate_sequence a, b do
    :error
  end

  @doc """
  Evaluates an expression in an environment AKA gives its value
  """
  @spec evaluate_expression(expression, environment) :: {:ok, strct} | :error
  def evaluate_expression {:atm, atom}, _ do
    {:ok, atom}
  end
  def evaluate_expression {:var, variable}, environment do
    case lookup(variable, environment) do
      nil ->
        :error
      {_, value} ->
        {:ok, value}
    end
  end
  def evaluate_expression {:cons, head, tail}, environment do
    case evaluate_expression(head, environment) do
      {:ok, value1} ->
        case evaluate_expression(tail, environment) do
          {:ok, value2} ->
            {:ok, {value1, value2}}
          :error ->
            :error
        end
      :error ->
        :error
    end
  end
  def evaluate_expression {:case, expression, clause}, environment do
    case evaluate_expression(expression, environment) do
      {:ok, value} ->
        evaluate_clause(clause, value, environment)
      :error ->
        :error
    end
  end
  def evaluate_expression {:lambda, parameters, free, sequence}, environment do
    case closure(free, environment) do
      closure ->
        {:ok, {:closure, parameters, sequence, closure}}
      :error ->
        :error
    end
  end
  def evaluate_expression {:apply, expression, arguments}, environment do
    case evaluate_expression(expression, environment) do
      {:ok, {:closure, parameters, sequence, closure}} ->
        case evaluate_arguments(arguments, environment) do
          {:ok, structs} ->
            evaluate_sequence(sequence, arguments(parameters, structs, closure))
          :error ->
            :error
        end
      :error ->
        :error
    end
  end

  def evaluate_expression {:fun, id}, env do
    {parameter, sequence} = apply(Prgm, id, [])
    {:ok, {:closure, parameter, sequence, new()}}
  end


  @doc """
  Matches given patterns with struct in an environment, if pattern is variable it returns a new
  environment with it bound AKA 1 = 1 gives ok and the same env, a=3 gives ok and a new env thats the old env but a=3
  """
  @spec evaluate_match(pattern, strct, environment) :: {:ok, environment} | :fail
  def evaluate_match :ignore, strct, environment do
    {:ok, environment}
  end
  def evaluate_match {:atm, id}, id, environment do
    {:ok, environment}
  end
  def evaluate_match {:var, variable}, strct, environment do
    case lookup(variable, environment) do
      {^variable, ^strct} ->
        {:ok, environment}
      nil ->
        {:ok, add(variable, strct, environment)}
      _ ->
        :fail
    end
  end
  def evaluate_match {:cons, head, tail}, {struct_head, struct_tail}, environment do
    case evaluate_match(head, struct_head, environment) do
      {:ok, environment} ->
        case evaluate_match(tail, struct_tail, environment) do
          {:ok, environment} ->
            {:ok, environment}
          :fail ->
            :fail
        end
      :fail ->
        :fail
    end
  end
  def evaluate_match _, _, _ do
    :fail
  end

  @doc """
  Removes the variables in the pattern from the environment
  """
  @spec evaluate_scope(pattern, environment) :: environment
  def evaluate_scope pattern, environment do
    remove(extract_variables(pattern), environment)
  end

  @doc """
  Evaluates clauses returning the value of the matched clause,
  First matches the pattern to the struct if, if sucessfull evaluates the sequence otherwise goes to the next clause
  """
  @spec evaluate_clause([clause], strct, environment) :: {:ok, strct} | :error
  def evaluate_clause [], _, _ do
    :error
  end
  def evaluate_clause [{:clause, pattern, sequence} | tail], strct, environment do
    case evaluate_match(pattern, strct, Enum.reverse(evaluate_scope(pattern, environment))) do
      {:ok, environment} ->
        evaluate_sequence(sequence, environment)
      :fail ->
        evaluate_clause(tail, strct, environment)
    end
  end

  @doc """
  Extracts variables from a pattern, stack heavy due to recursion can be done with enumeration and list shenanigans
  """
  @spec extract_variables(pattern) :: [variable]
  def extract_variables pattern do
    extract_variables(pattern, new())
  end

  @spec extract_variables(pattern, [variable]) :: [variable]
  def extract_variables {:var, variable}, [variables] do
    [ variable | variables]
  end
  def extract_variables {:cons, head, tail}, variables do
    extract_variables(tail, extract_variables(head, variables))
  end
  def extract_variables _, variables do
    variables
  end

  @doc """
  Evaluates the arguments of a closure
  """
  @spec evaluate_arguments([expression], environment) :: {:ok, [strct]} | :error
  def evaluate_arguments expressions, environment do
    evaluate_arguments(expressions, environment, [])
  end

  @spec evaluate_arguments([expression], environment, [strct]) :: {:ok, [strct]} | :error
  def evaluate_arguments [], _, structs do
    {:ok, Enum.reverse(structs)}
  end
  def evaluate_arguments [expression | expressions], environment, structs do
    case evaluate_expression(expression, environment) do
      {:ok, strct} ->
        evaluate_arguments(expressions, environment, [strct|structs])
      :error ->
        :error
    end
  end
end
