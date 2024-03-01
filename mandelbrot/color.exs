defmodule Color do
  def convert depth, max do
    example(depth, max)
  end

  defp example depth, max do
    a = (depth/max)*5
    x = trunc(a)
    y = (a-x)*65535 |> round()
    case x do
      0 ->
        "#{y} 0 0"
      1 ->
        "65535 #{y} 0"
      2 ->
        "#{65535-y} 65535 0"
      3 ->
        "0 65535 #{y}"
      4 ->
        "0 #{65535-y} 65535"
      5 ->
        "0 0 #{65535-y}"
    end
  end
end
