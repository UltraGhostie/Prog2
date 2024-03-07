defmodule Decode do
  def decode([], _) do
    nil
  end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    case decode(rest, table) do
      nil ->
        char
      a ->
        char ++ a
    end
  end

  def decode_char [], _, _ do
    []
  end
  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest}
      nil ->
        decode_char(seq, n+1, table)
    end
  end
end
