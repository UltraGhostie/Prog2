defmodule Springs3 do
    import Bitwise
    def testtime iterations do
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
      Enum.map(spring_array, fn x -> IO.inspect(calculate(x)) end)
      |> IO.inspect(charlists: :as_list)
    end

    def calculate spring do
      {description, sequence} = spring_split(spring)
      sequence = sequence_split(sequence)
      max_depth = Enum.reduce(sequence, 0, fn x, y -> y+1 end)
      max_length = Enum.reduce(sequence, 0, fn x, y -> x+y end)
      description = String.to_charlist(description)
      memory = Map.new()
      {permutations, memory} = permutate(description, max_depth, max_length, memory, sequence)
      sizep = Enum.reduce(permutations, 0, fn x, y -> y+1 end)
      sizem = Enum.reduce(Map.to_list(memory), 0, fn x, y -> y+1 end)
      Enum.reduce(Map.to_list(memory), 0, fn x, y ->
        {_, a} = x
        a+1+y
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

    def optimise integer do
      bin_to_string(integer)
      |> String.split("0", trim: true)
      |> join("0")
      |> String.to_integer(2)
    end

    def memory_check integer, memory, sequence do
      case Map.fetch(memory, integer) do
        {:ok, -1} ->
          {[], memory}
        {:ok, nil} ->
          {[integer], Map.put(memory, integer, fit(integer, sequence))}
        :error ->
          {[integer], Map.put(memory, integer, fit(integer, sequence))}
        {:ok, result} ->
          {[integer], Map.put(memory, integer, result+1)}
      end
    end

    def permutate [], max_depth, max_length, memory, sequence, length, depth, integer do
      cond do
        length < max_length ->
          {[], memory}
        depth < max_depth ->
          {[], memory}
        true ->
          memory_check(integer, memory, sequence)
      end
    end
    def permutate(_stuff, _integer, max_length, memory, _sequence, length, _, _int) when length > max_length do
      {[], memory}
    end
    def permutate [head|tail], max_depth, max_length, memory, sequence, length \\ 0, depth \\ 0, integer \\ 0 do
      cond do
        (depth < max_depth) || (depth == max_depth && ((integer&&&0b1) == 0b1))->
          case <<head>> do
            "." ->
              case integer&&&0b1 do
                0b1 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length, depth, (integer<<<1))
                0b0 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length, depth, integer)
              end
            "#" ->
              case integer&&&0b1 do
                0b1 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length+1, depth, (integer<<<1)|||0b1)
                0b0 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length+1, depth+1, (integer<<<1)|||0b1)
              end
            "?" ->
              case integer&&&0b1 do
                0b1 ->
                  {permutations, memory} = permutate(tail, max_depth, max_length, memory, sequence, length, depth, (integer<<<1))
                  {permutations2, memory} = permutate(tail, max_depth, max_length, memory, sequence, length+1, depth, (integer<<<1)|||0b1)
                  {permutations++permutations2, memory}
                0b0 ->
                  {permutations, memory} = permutate(tail, max_depth, max_length, memory, sequence, length, depth, integer)
                  {permutations2, memory} = permutate(tail, max_depth, max_length, memory, sequence, length+1, depth+1, (integer<<<1)|||0b1)
                  {permutations++permutations2, memory}
              end
          end
        (depth == max_depth) ->
          case <<head>> do
            "." ->
              case integer&&&0b1 do
                0b1 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length, depth, (integer<<<1))
                0b0 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length, depth, integer)
              end
            "#" ->
              case integer&&&0b1 do
                0b1 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length+1, depth, (integer<<<1)|||0b1)
                0b0 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length+1, depth+1, (integer<<<1)|||0b1)
              end
            "?" ->
              case integer&&&0b1 do
                0b1 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length, depth, (integer<<<1))
                0b0 ->
                  permutate(tail, max_depth, max_length, memory, sequence, length, depth, integer)
              end
          end
        depth > max_depth ->
          {[], memory}
      end
    end


    def spring_split spring do
      String.split(spring)
      |> List.to_tuple()
    end

    def sequence_split sequence do
      String.split(sequence, ",")
      |> Enum.map(fn x -> String.to_integer(x) end)
      |> reverse()
    end

  def join [head|tail], char do
    case tail do
      [] ->
        head
      [""] ->
        head
      _ ->
        head <> char <> join(tail, char)
    end
  end

  def bin_to_string 0 do
    "0"
  end
  def bin_to_string integer do
    case integer&&&0b1 do
      0b1 ->
        bin_to_string(integer>>>1, "1")
      _ ->
        bin_to_string(integer>>>1, "0")
    end
  end
  def bin_to_string 0, string do
    string
  end
  def bin_to_string integer, string do
    case integer&&&0b1 do
      0b1 ->
        bin_to_string(integer>>>1, "1"<>string)
      _ ->
        bin_to_string(integer>>>1, "0"<>string)
    end
  end
end
