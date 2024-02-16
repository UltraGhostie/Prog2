defmodule Springs1 do
  import Bitwise
  def timetest iterations do
    {:ok, springs} = File.read("springs.txt")
    spring_array = String.split(springs, "\n")
    Enum.map(spring_array, fn x -> time(x, iterations) end)
    |> IO.inspect(charlists: :as_list)
  end

  def time spring, iterations do
    Enum.reduce(1..iterations, 0, fn x, y ->
      {time, _} = :timer.tc(fn() -> calculate(spring) end)
      y+time
    end)
    |> div(iterations)
  end

  def test do
    {:ok, springs} = File.read("springs.txt")
    spring_array = String.split(springs, "\n")
    Enum.map(spring_array, fn x -> calculate(x) end)
    |> IO.inspect(charlists: :as_list)
  end

  def calculate spring do
    {description, sequence} = spring_split(spring)
    sequence = sequence_split(sequence)
    description = String.to_charlist(description)
    permutations = permutate(description)
    Enum.reduce(permutations, 0,
    fn x, y ->
      case fit(x, reverse(sequence)) do
        0 ->
          y+1
        _ ->
          y
      end
    end)
  end

  def reverse [] do
    []
  end
  def reverse [head|tail] do
    reverse(tail)++[head]
  end

  def fit permutation, [] do
    permutation
  end
  def fit permutation, [head|tail] do
    shift(permutation)
    |> check(head)
    |> fit(tail)
  end

  def check bits, 0 do
    cond do
      (bits&&&0b1) == 0b0 ->
        bits
      true ->
        -1
    end
  end
  def check bits, amount do
    cond do
      (bits&&&0b1) == 0b1 ->
        check(bits>>>1, amount-1)
      true ->
        -1
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
