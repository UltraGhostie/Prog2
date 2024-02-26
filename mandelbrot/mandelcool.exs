defmodule Mandelcool do
  def mandelbrot width, height, x, y, k, depth do
    trans = fn(w, h) ->
      Complex.new(x + k * (w - 1), y - k * (h - 1))
    end
      min = 0
      max = trunc(height/8)
      incr = max
      t1 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 0-4
      min = min+incr+1
      max = min+incr
      t2 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 5-8
      min = min+incr
      max = min+incr
      t3 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 9-12
      min = min+incr
      max = min+incr
      t4 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 13-16
      min = min+incr
      max = min+incr
      t5 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 13-16
      min = min+incr
      max = min+incr
      t6 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 13-16
      min = min+incr
      max = min+incr
      t7 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 13-16
      min = min+incr
      max = min+incr
      t8 = Task.async(fn -> rows(width, min..max, max, trans, depth, []) end) # 13-16
      [a, b, c, d, e, f, g, h] = Task.await_many([t1, t2, t3, t4, t5, t6, t7, t8], 5*60*1000)
      h++g++f++e++d++c++b++a
  end


  def thread width, min..max, trans, depth do
    Task.async(fn -> rows(width, min..max, max, trans, depth, []) end)
  end

  def rows _, min.._, min, _, _, list do
    list
  end
  def rows width, min..max, current, function, depth, list do
    rows(width, min..max, current-1, function, depth, list++[row(width, current, function, depth, [])])
  end

  def row 0, _, _, _, list do
    list
  end
  def row width, height, function, depth, list do
    row(width-1, height, function, depth, list++[pixel(width, height, function, depth)])
  end

  defp pixel width, height, function, depth do
    function.(width, height)
    |> Brot.mandelbrot(depth)
    |> Color.convert(depth)
  end
end
