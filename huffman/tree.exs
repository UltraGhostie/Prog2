defmodule Tree do
  def tree(sample) do
    freq(sample)
    |> Map.to_list()
    |> to_nodelist
    |> huffman()
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
end
