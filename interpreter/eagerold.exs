defmodule Eager do
  import Listmap
  @type atm :: {:atm, atom}
  @type variable :: {:var, atom}
  @type ignore :: :ignore
  @type cons(t) :: {:cons, t, t}

  # Pattern matching
  @type pattern :: atm | variable | ignore | cons(pattern)

  @type lambda :: {:lambda, [atom], [atom], sequence}
  @type apply :: {:apply, expression, [expression]}
  @type case :: {:case, expression, [clause]}
  @type clause :: {:clause, pattern, sequence}

  @type expression :: atm | variable | lambda | apply | case | cons(expression)

  # Sequences
  @type match :: {:match, pattern, expression}
  @type sequence :: [expression] | [match | sequence]

  # Expressions are evaluated to strctures.
  @type closure :: {:closure, [atom], sequence, environment}
  @type strct :: atom | [strct] | closure

  # An environment is a key-value of variableiable to strcture.
  @type environment :: [{atom, strct}]

  @spec evaluate(sequence) :: {:ok, strct} | :fail

  def evaluate(sequence) do
    environment = new()
    #evaluate_sequence(expression, environment)
  end

  @spec evaluate_expression(expression, environment) :: {:ok, strct} | :error

  def evaluate_expression({:atm, id}, _) do {:ok, id} end
  def evaluate_expression({:var, id}, environment) do
    case lookup(id, environment) do
      nil ->
        :fail
      {_, value} ->
        evaluate_expression(value, environment)
    end
  end
  def evaluate_expression({:cons, head, tail}, environment) do
    case evaluate_expression(head, environment) do
      :fail ->
        :fail
      {:ok, x} ->
        case evaluate_expression(tail, environment) do
          :fail ->
            :fail
          {:ok, y} ->
            {:ok, {x, y}}
        end
    end
  end
  def evaluate_expression(_, _) do :fail end

  @spec evaluate_match(pattern, strct, environment) :: {:ok, environment} | :fail

  def evaluate_match({:atm, a}, strct, environment) do
    cond do
      a == strct ->
        {:ok, environment}
      true ->
        :fail
    end
  end
  def evaluate_match({:var, x}, strct, environment) do
    case lookup(x, environment) do
      {_, ^strct} ->
        {:ok, environment}
      nil ->
        {:ok, add(x, strct, environment)}
      _ ->
        :fail
    end
  end
  def evaluate_match(:ignore, _, environment) do {:ok, environment} end
  def evaluate_match({:cons, head, tail}, {:var, a}, environment) do
    case lookup(a, environment) do
      {_, {:cons, a, b}} ->
        case evaluate_match(head, a, environment) do
          {:ok, environment1} ->
            case evaluate_match(tail, b, environment1) do
              {:ok, environment2} ->
                {:ok, environment2}
              _ ->
                :fail
            end
            _ ->
              :fail
        end
      _ ->
        :fail
    end
  end
  def evaluate_match({:cons, head, tail}, {a, b}, environment) do
    case evaluate_match(head, a, environment) do
      {:ok, environment1} ->
        case evaluate_match(tail, b, environment1) do
          {:ok, environment2} ->
            {:ok, environment2}
          _ ->
            :fail
        end
        _ ->
          :fail
    end
  end

  def evaluate_match(_, _, _) do :fail end

  @spec extract_variables(pattern) :: [variable]
  def extract_variables({_, e1, e2}) do clean([extract_variables(e1), extract_variables(e2)]) end
  def extract_variables({:var, v}) do v end
  def extract_variables({:atm, _}) do nil end
  def extract_variables(:ignore) do nil end
  def extract_variables(expression) do clean(Enum.reduce(expression, [], fn x, acc -> [extract_variables(x) | acc] end)) end

  def clean(list) do Enum.uniq(List.flatten(list)) -- [nil] end

  @spec evaluate_scope(pattern, environment) :: environment

  def evaluate_scope(expression, environment) do remove(extract_variables(expression), environment) end

  @spec evaluate_clause([clause], strct, environment) :: {:ok, strct} | :error

  def evaluate_clause([], _, _) do
    :error
  end
  def evaluate_clause([{:clause, pattern, sequence} | clause], strct, environment) do
    case evaluate_match(pattern, strct, evaluate_scope(pattern, environment)) do
      :fail ->
        evaluate_clause(clause, strct, environment)
      {:ok, environment} ->
        evaluate_sequence(sequence, environment)
    end
  end

  @spec evaluate_sequence([expression], environment) :: {:ok, strct} | :error



  def evaluate_sequence([expression], environment) do
    evaluate_expression(expression, environment)
  end
  def evaluate_sequence([{:case, expression, clause} | _tail], environment) do
    case evaluate_expression(expression, environment) do
      {:ok, expression} ->
        evaluate_clause(clause, expression, environment)
      :fail ->
        :clauseerror
    end
  end
  def evaluate_sequence([{:match, a, b} | tail], environment) do
    case evaluate_match(a, b, environment) do
      :fail ->
        :matcherror
      {:ok, environment} ->
        evaluate_sequence(tail, environment)
    end
  end
  def evaluate_sequence([{:var, v}], environment) do
    {_, value} = lookup(v, environment)
    {_, value} = evaluate_expression(value, environment)
    value
  end
  def evaluate_sequence({:var, v}, environment) do
    {_, value} = lookup(v, environment)
    {_, value} = evaluate_expression(value, environment)
    value
  end
  def evaluate_sequence([], environment) do environment end
end
