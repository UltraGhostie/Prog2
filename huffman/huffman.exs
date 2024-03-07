defmodule Huffman do
  import Bitwise
  def sample do
    'detta är en test text som innehåller de flesta bokstäver i en å av ord som flodar fram. Ibland finns det extra tecken som en ö i havet. GLÖM INTE ALLA STORA BOKSTÄVER: DET HADE VARIT FEL!abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ'
  end

  def text() do
    'test'
  end

  def test do
    # {:ok, text} = File.read("text.txt")
    # text = String.to_charlist(text)
    text = text()
    tree = tree(sample())
    encode = encode_table(tree)
    # decode = decode_table(tree)
    num = encode(text, encode)
    text = decode(num, encode) |> Enum.reverse()
    File.write("test.txt", text)
    IO.inspect(encode)
    IO.inspect(bin_to_string(num))
    Enum.each('test', fn x -> IO.inspect(Enum.filter(encode, fn y ->
      case y do
        {[^x], _} -> true
        _ -> false
      end end)) end)
  end

  def bin_to_string integer do
    case integer&&&0b1 do
      0b1 ->
        bin_to_string(integer>>>1, "1")
      _ ->
        bin_to_string(integer>>>1, "0")
    end
  end
  def bin_to_string 0, string do
    string
  end
  def bin_to_string integer, string do
    case integer&&&0b1 do
      0b1 ->
        bin_to_string(integer>>>1, "1"<>string)
      _ ->
        bin_to_string(integer>>>1, "0"<>string)
    end
  end

  def tree(sample) do
    freq(sample)
    |> Map.to_list()
    |> to_nodelist
    |> huffman()
  end

  def encode_table huff do
    encode_table(huff, 1)
  end
  def encode_table{key, _, left, right}, path do
    case Enum.count(key) do
      1 ->
       [{key, <<path>>}]
      _ ->
        encode_table(left, path<<<1)++encode_table(right, (path<<<1)|||1)
    end
  end

  def decode_table(tree) do
    tree
  end

  def encode text, table do
    encode(text, table, 1)
  end
  def encode [], _, code do
    code
  end
  def encode [head|tail], table, code do
    encode(tail, table, conc(code, lookup(table, [head])))
  end

  def conc a, <<b>> do
    conc(a, b>>>1)
  end
  def conc a, b do
    case b|||1 do
      1 ->
        a
      _ ->
        conc((a<<<1)|||(b&&&1), b>>>1)
    end
  end

  def lookup table, item do
    [{_,value}|_] = Enum.drop_while(table, fn {key,_} -> key != item end)
    value
  end

  def decode(1, _) do
    ''
  end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    char ++ decode(rest, table)
  end

  def decode_char 0, _, _ do
    {'', 1}
  end
  def decode_char(seq, n, table) do
    code = (seq &&& generate(n)) |> reverse(n)
    code = code|||(1<<<(n))
    rest = seq >>> n
    case List.keyfind(table, <<code>>, 1) do
      {char, _} ->
        {char, rest}
      nil ->
        decode_char(seq, n+1, table)
      end
  end

  def reverse bin, n do
    reverse(bin, n, 0)
  end
  def reverse _, 0, out do
    out
  end
  def reverse bin, n, out do
    reverse(bin>>>1, n-1, (out<<<1)|||(bin&&&1))
  end

  def generate n do
    generate(n, 0)
  end
  def generate 0, bin do
    bin
  end
  def generate n, bin do
    generate(n-1, (bin<<<1)|||1)
  end

  def huffman list do
    case Enum.count(list) do
      1 ->
        [tree] = list
        tree
      _ ->
        least = least(list)
        list = list -- [least]
        nleast = least(list)
        list = list -- [nleast]
        {lkey, lval, _, _} = least
        {nlkey, nlval, _, _} = nleast
        {key, value, _, _} = Treemap.new() |> Treemap.add(lkey++nlkey, lval+nlval)
        [{key, value, least, nleast}]++list
        |> huffman()
    end
  end

  def to_nodelist list do
    to_nodelist(list, [])
  end
  def to_nodelist [], list do
    list
  end
  def to_nodelist [{key, value}|tail], list do
    node = Treemap.new() |> Treemap.add([key], value)
    list=[node]++list
    to_nodelist(tail, list)
  end

  def least freq do
    Enum.reduce(freq, {nil, -1, nil, nil}, fn {node, count, l, r}, {l_node, l_count, a, b} ->
      cond do
        l_count == -1 ->
          {node, count, l, r}
        count < l_count ->
          {node, count, l, r}
        true ->
          {l_node, l_count, a, b}
      end
    end)
  end

  def freq(sample) do
    freq(sample, Map.new())
  end
  def freq([], freq) do
    freq
  end
  def freq([char | rest], freq) do
    case Map.fetch(freq, char) do
      {:ok, count} ->
        freq(rest, Map.put(freq, char, count+1))
      :error ->
        freq(rest, Map.put(freq, char, 1))
    end
  end
end
