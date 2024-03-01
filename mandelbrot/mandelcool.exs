defmodule Mandelcool do
  import Bitwise
  def mandelbrot width, height, x, y, k, depth do
    trans = fn(w, h) ->
      Complex.new(x+k*(w-1), y-k*(h-1))
    end
      min = 0
      max = height>>>3
      incr = max
      IO.inspect(min..max)
      IO.inspect(incr)
      t1 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr+1
      max = max+incr
      IO.inspect(min..max)
      t2 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr
      max = max+incr
      IO.inspect(min..max)
      t3 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr
      max = max+incr
      IO.inspect(min..max)
      t4 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr
      max = max+incr
      IO.inspect(min..max)
      t5 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr
      max = max+incr
      IO.inspect(min..max)
      t6 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr
      max = max+incr
      IO.inspect(min..max)
      t7 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      min = min+incr
      max = max+incr
      IO.inspect(min..max)
      t8 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
      Task.await_many([t8, t7, t6, t5, t4, t3, t2, t1], 40*60*1000)
      |> Enum.join(" ")
  end

  def rows _, min.._, min, _, _, list do
    Enum.reverse(list) |> Enum.join(" ")
  end
  def rows width, min..max, current, function, depth, list do
    rows(width, min..max, current-1, function, depth, [row(width, current, function, depth, [])]++list)
  end

  def row 0, _, _, _, list do
    Enum.reverse(list) |> Enum.join(" ")
  end
  def row width, height, function, depth, list do
    row(width-1, height, function, depth, [pixel(width, height, function, depth)]++list)
  end

  defp pixel width, height, function, depth do
    function.(width, height)
    |> Brot.mandelbrot(depth)
    |> Color.convert(depth)
  end
end
