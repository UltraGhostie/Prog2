defmodule Test do
  def test do
    Parser.parse("seeds.txt")
    |> Transformer.multi_transform()
    |> Enum.min()
    |> IO.inspect(charlists: :as_list)
  end
end
