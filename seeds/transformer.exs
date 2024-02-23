defmodule Transformer do
  def multi_transform {values, maps_list} do
    Enum.reduce(maps_list, values, fn x, y -> transform(x, y) end)
  end

  def transform maps, values do
    Enum.map(values, fn x ->
      case Enum.drop_while(maps, fn {range, _} -> !Enum.member?(range, x) end) do
        [{_, map}|_] ->
          x + map
        _ ->
          x
      end
    end)
  end
end
