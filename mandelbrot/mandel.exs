defmodule Mandel do
  def mandelbrot width, height, x, y, k, depth do
    trans = fn(w, h) ->
      Complex.new(x + k * (w - 1), y - k * (h - 1))
    end
      rows(width, height, trans, depth, [])
  end

  defp rows _, 0, _, _, list do
    list
  end
  defp rows width, height, function, depth, list do
    rows(width, height-1, function, depth, list++[row(width, height, function, depth, [])])
  end

  defp row 0, _, _, _, list do
    list
  end
  defp row width, height, function, depth, list do
    row(width-1, height, function, depth, list++[pixel(width, height, function, depth)])
  end

  defp pixel width, height, function, depth do
    function.(width, height)
    |> Brot.mandelbrot(depth)
    |> Color.convert(depth)
  end
end
