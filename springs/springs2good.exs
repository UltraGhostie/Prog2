defmodule Springs2good do
  import Bitwise
  import Map
  def test do
    {:ok, springs} = File.read("springs.txt")
    spring_array = String.split(springs, "\n")
    Enum.map(spring_array, fn x -> calculate(x) end)
    |> IO.inspect(charlists: :as_list)
  end

  def calculate spring do
    calculate(spring, new())
  end
  def calculate spring, memory do
    {description, sequence} = spring_split(spring)
    sequence = reverse(sequence_split(sequence))
    description = String.to_charlist(description)
    permutations = permutate(description)
    {result, memory} = Enum.reduce(permutations, {0, memory},
    fn x, {y, memory} ->
      {result, memory} = fit({x, memory}, sequence)
      {y+1+result, memory}
    end)
    result
  end


  def reverse [] do
    []
  end
  def reverse [head|tail] do
    reverse(tail)++[head]
  end

  def fit {permutation, memory}, [] do
    case permutation do
      0 ->
        {0, memory}
      _ ->
        {-1, memory}
    end
  end
  def fit {permutation, memory}, [head|tail] do
    shift(permutation)
    |> mem_check([head|tail], memory)
    |> fit(tail)
  end

  def mem_check permutation, [head|tail], memory do
    case check_memory({permutation, [head|tail]}, memory) do
      :error ->
        check(permutation, head, memory)
        |> memory_add(permutation, [head|tail])
      result ->
        {result, memory}
    end
  end

  def find [], _ do
    :error
  end
  def find [head|tail], item do
    case head do
      ^item ->
        item
      _ ->
        find(tail, item)
    end
  end

  def check_memory {-1, _}, _ do
    -1
  end
  def check_memory {binary, sequence}, memory do
    case fetch(memory, binary) do
      {:ok, result} ->
        case find(result, sequence) do
          {:ok, result} ->
            result
          _ ->
            :error
        end
      _ ->
        :error
    end
  end
  def check_memory _, _ do
    :error
  end

  def memory_add({result, memory}, permutation, sequence) do
    case result do
      -1 ->
        case fetch(memory, permutation) do
          :error ->
            {result, put(memory, permutation, [sequence])}
          {:ok, sequence_memory} ->
            {result, put(memory, permutation, [sequence]++sequence_memory)}
        end
      _ ->
        {result, memory}
    end
  end

  def check bits, 0, memory do
    cond do
      (bits&&&0b1) == 0b0 ->
        {bits, memory}
      true ->
        {-1, memory}
    end
  end
  def check bits, amount, memory do
    cond do
      (bits&&&0b1) == 0b1 ->
        check(bits>>>1, amount-1, memory)
      true ->
        {-1, memory}
    end
  end

  def shift bits do
    cond do
      (bits&&&0b1) == 0b1 ->
        bits
      bits > 0 ->
        shift(bits>>>1)
      true ->
        0
    end
  end

  def permutate integer, [] do
    [integer]
  end
  def permutate integer, [head|tail] do
    case <<head>> do
      "." ->
        permutate((integer<<<1), tail)
      "#" ->
        permutate((integer<<<1)|||0b1, tail)
      "?" ->
        permutate((integer<<<1), tail) ++ permutate((integer<<<1)|||0b1, tail)
    end
  end
  def permutate [head|tail] do
    case <<head>> do
      "." ->
        permutate(0, tail)
      "#" ->
        permutate(1, tail)
      "?" ->
        permutate(0, tail) ++ permutate(1, tail)
    end
  end


  def spring_split spring do
    String.split(spring)
    |> List.to_tuple()
  end

  def sequence_split sequence do
    String.split(sequence, ",")
    |> Enum.map(fn x -> String.to_integer(x) end)
  end
end
