defmodule Encode do
  import Bitwise
  def encode text, table do
    encode(text, table, [])
  end
  def encode [], _, code do
    code
  end
  def encode [head|tail], table, code do
    encode(tail, table, code++lookup(table, [head]))
  end

  def encode_table huff do
    encode_table(huff, [])
  end
  def encode_table{key, _, left, right}, path do
    case Enum.count(key) do
      1 ->
       [{key, path}]
      _ ->
        encode_table(left, path++[0])++encode_table(right, path++[1])
    end
  end

  def lookup table, item do
    case Enum.drop_while(table, fn {key,_} -> key != item end) do
      [{_,value}|_] ->
        value
      _ ->
        IO.inspect(item, label: "FTF")
        Process.exit(self(), :kill)
    end
  end
end
