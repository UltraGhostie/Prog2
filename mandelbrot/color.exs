defmodule Color do
  def convert depth, max do
    example(depth, max)
  end

  defp example depth, max do
    a = depth/max |> mul(4)
    x = trunc(a)
    y = a-x |> mul(255) |> trunc()
    case x do
      0 ->
        {y,0,0}
      1 ->
        {255,y,0}
      2 ->
        {255-y,255,0}
      3 ->
        {0,255,y}
      4 ->
        {0,255-y,255}
    end
  end
  defp mul a, b do
    a*b
  end
end
