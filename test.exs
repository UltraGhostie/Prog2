defmodule Test do # Code with # next to it is taken from video lectures
  import Deriv
  import Simplify
  import Pprint

  def test() do #
    benchmark({:div, {:num, 1}, {:sin, {:mul, {:num, 2}, {:var, :x}}}})
    benchmark({:exp, {:add, {:mul, {:num, 2}, {:exp, {:var, :x}, {:num, 3}}}, {:num, 5}}, {:num, 2}}) ###
    benchmark({:exp, {:var, :x}, {:div, {:num, 1}, {:num, 2}}})
    benchmark({:exp, {:var, :x}, {:num, 2}})
    benchmark({:div, {:num, -1}, {:num, 2}})
    benchmark({:exp, {:var, :x}, {:div, {:num, -1}, {:num, 2}}}) ###
  end

  def benchmark(e) do
    IO.write("#{pprint(simplify(e))}\n")
    t = Time.truncate(Time.utc_now(), :microsecond)
    Enum.each(0..99999, fn(x) -> pprint(simplify(deriv(e, :x))) end)
    dt = Time.diff(Time.truncate(Time.utc_now(), :microsecond), t, :microsecond) / 100000
    IO.write("#{pprint(simplify(deriv(e, :x)))}\n") #
    IO.write("#{dt} ms\n")
    #simplify(deriv(e, :x))
  end

end
