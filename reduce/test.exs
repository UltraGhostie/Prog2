defmodule Test do
  def test do
    e = [1,2,3,4,5]
    IO.inspect(Part1.rlength(e))
    IO.inspect(Part1.even(e))
    IO.inspect(Part1.odd(e))
    IO.inspect(Part1.sum(e))
    IO.inspect(Part1.inc(e, 1))
    IO.inspect(Part1.dec(e, 1))
    IO.inspect(Part1.mul(e, 2))
  end

  def test2 do
    e = Enum.to_list(1..20)
    IO.inspect(Part2.map(e, fn x -> x+1 end))
    IO.inspect(Part2.reducel(e, 0, fn x, y -> x+y end))
    IO.inspect(Part2.filter3(e, fn x -> rem(x,2)==0 end))

    IO.inspect(Part2.rlength(e))
    IO.inspect(Part2.even(e))
    IO.inspect(Part2.even2(e))
    IO.inspect(Part2.odd(e))
    IO.inspect(Part2.sum1(e))
    # IO.inspect(Part2.sum2(e))
    IO.inspect(Part2.inc(e, 1))
    IO.inspect(Part2.dec(e, 1))
    IO.inspect(Part2.mul(e, 2))
    IO.inspect(Part2.square_sum(e))
    #IO.inspect(Part2.prime(e))
  end

  def testtimes size \\ 1000, iterations \\ 1000 do
    e = Enum.to_list(1..size)
    time([0], fn list -> Part1.rlength(list) end, e, iterations)
    |> time(fn list -> Part1.sum(list) end, e, iterations)
    |> time(fn list -> Part1.even(list) end, e, iterations)
    |> time(fn list -> Part1.odd(list) end, e, iterations)
    |> time(fn list -> Part1.inc(list, 1) end, e, iterations)
    |> time(fn list -> Part1.dec(list, 1) end, e, iterations)
    |> time(fn list -> Part1.mul(list, 2) end, e, iterations)
  end

  def testtimes2 size \\ 1000, iterations \\ 1000 do
    e = Enum.to_list(1..size)
    time([0], fn list -> Part2.rlength(list) end, e, iterations)
    |> time(fn list -> Part2.sum1(list) end, e, iterations)
    |> time(fn list -> Part2.even(list) end, e, iterations)
    |> time(fn list -> Part2.even2(list) end, e, iterations)
    |> time(fn list -> Part2.odd(list) end, e, iterations)
    # |> time(fn list -> Part2.sum2(list) end, e, iterations)
    |> time(fn list -> Part2.inc(list, 1) end, e, iterations)
    |> time(fn list -> Part2.dec(list, 1) end, e, iterations)
    |> time(fn list -> Part2.mul(list, 2) end, e, iterations)
    |> time(fn list -> Part2.square_sum(list) end, e, iterations)
    |> time(fn list -> Part2.square_sum2(list) end, e, iterations)
    # |> time(fn list -> Part2.prime(list) end, e, iterations)
  end

  def time [head|tail], function, list, iterations do
    iterator = Enum.to_list(1..iterations)
    {time, _} = :timer.tc(fn() -> Enum.each(iterator, fn _x -> function.(list) end) end)
    [trunc(time/iterations)] ++ [head] ++ tail
  end
end
