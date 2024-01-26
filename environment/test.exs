defmodule Test do
  import Listmap
  import Treemap
  def test(i \\ 100, n \\ 100) do
    seq = Enum.map(1..n, fn(_) -> :rand.uniform(n*i) end)
    treelist = Enum.reduce(seq, Treemap.new(), fn(e, treelist) -> Treemap.add(treelist, e, :foo) end)
    list = Enum.reduce(seq, Listmap.new(), fn(e, list) -> Listmap.add(list, e, :foo) end)
    map = Enum.reduce(seq, Map.new(), fn(e, map) -> Map.put(map, e, :foo) end)
    seq = Enum.map(1..i, fn(_) -> :rand.uniform(n*i) end)
    IO.write("Testing add...\n")
    {tt, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Treemap.add(treelist, e, :foo) end) end)
    {tl, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Listmap.add(list, e, :foo) end) end)
    {tm, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Map.put(map, e, :foo) end) end)
    IO.write("Tree: #{tl}, List:#{tt}, Map:#{tm}\n")
    IO.write("Testing lookup...\n")
    {tt, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Treemap.lookup(treelist, e) end) end)
    {tl, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Listmap.lookup(list, e) end) end)
    {tm, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Map.get(map, e) end) end)
    IO.write("Tree: #{tl}, List:#{tt}, Map:#{tm}\n")
    IO.write("Testing remove...\n")
    {tt, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Treemap.remove(e, treelist) end) end)
    {tl, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Listmap.remove(e, list) end) end)
    {tm, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) -> Map.delete(map, e) end) end)
    IO.write("Tree: #{tl}, List:#{tt}, Map:#{tm}\n")
  end

  def testTreeMap() do
    map = Treemap.new()
    map = Treemap.add(map, 8, :rand.uniform(3000))
    map = Treemap.add(map, 7, :rand.uniform(3000))
    map = Treemap.add(map, 13, :rand.uniform(3000))
    map = Treemap.add(map, 4, :rand.uniform(3000))
    map = Treemap.add(map, 6, :rand.uniform(3000))
    map = Treemap.add(map, 9, :rand.uniform(3000))
    map = Treemap.add(map, 22, :rand.uniform(3000))
    map = Treemap.add(map, 21, :rand.uniform(3000))
    map = Treemap.add(map, 12, :rand.uniform(3000))
    map = Treemap.add(map, 3, :rand.uniform(3000))
    map = Treemap.add(map, 1, :rand.uniform(3000))
    map = Treemap.remove(6, map)
    map
  end




  def testListMap() do
    map = Listmap.new()
    map = Listmap.add(map, {:a, 1})
    map = Listmap.add(map, {:b, 2})
    map = Listmap.add(map, {:c, 3})
    map = Listmap.add(map, {:d, 4})
    map = Listmap.add(map, {:e, 5})

    t = Listmap.lookup(map, :e)

    map = Listmap.remove(:e, map)
    map
  end
end
