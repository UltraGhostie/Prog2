defmodule Brot do
  def mandelbrot c, max do
    z0 = Complex.new()
    i = 0
    test(z0, i, c, max)
  end

  defp test z, max, c, max do 0 end
  defp test z, i, c, max do
    z = Complex.square(z) |> Complex.add(c)
    cond do
      Complex.abs(z) > 2 ->
        i
      true ->
        test(z, i+1, c, max)
    end
  end
end
