defmodule Listmap do
  def new() do [] end

  def add(l, k, v) do add(l, {k,v}) end
  def add([{key,_}|t], {key,val}) do [{key,val}|t] end
  def add([], z) do z end
  def add([h|t], z) do add(t, [h|z]) end
  def add(h, z) do add([], [h|z]) end

  def lookup([], _) do {:error, :failtofind} end
  def lookup([{k,v}|t], key) do
    case k do
      ^key ->
        {:ok, {k,v}}
      _ ->
        lookup(t, key)
    end
  end
  def lookup({k,v}, key) do lookup([{k,v}], key) end

  def remove(_, []) do {:error, :emptylist} end
  def remove(key, [{h,v}|t]) do
    case h do
      ^key ->
        t
      _ ->
        [{h,v}|remove(key, t)]
    end
  end
  def remove(key, {k,v}) do remove(key, [{k,v}]) end
end
