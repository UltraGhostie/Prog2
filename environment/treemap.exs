defmodule Treemap do
  def new() do nil end


  def add({k,v,l,r}, key, value) when key < k do {k,v,add(l, key, value),r} end
  def add({key,_,_,_}, {key,v,l,r}) do {key,v,l,r} end
  def add({key,_,l,r}, key, value) do {key, value, l, r} end
  def add({k,v,l,r}, key, value) do {k,v,l,add(r, key, value)} end
  def add(nil, key, value) do {key, value, nil, nil} end
  def add(map, nil) do map end
  def add({k,v,l,r}, {key, value, left, right}) when key < k do {k,v,add(l, {key, value, left, right}), r} end
  def add({k,v,l,r}, {key, value, left, right}) do {k,v,l,add(r, {key, value, left, right})} end
  def add(nil, t) do t end

  def lookup({k,v,l,r}, key) do
    cond do
      k<key ->
        lookup(r, key)
      k>key ->
        lookup(l, key)
      k==key ->
        {:ok, v}
      end
  end
  def lookup(nil, _) do {:error, :failtofind} end

  def remove(_, nil) do {:error, :emptylist} end
  def remove(key, {k,v,l,r}) when key < k do {k,v,remove(key,l),r} end
  def remove(key, {k,v,l,r}) when key > k do {k,v,l,remove(key,r)} end
  def remove(key, {key,_,nil,nil}) do nil end
  def remove(key, {key,_,nil,r}) do r end
  def remove(key, {key,_,l,nil}) do l end
  def remove(key, {key,_,l,r}) do
    {lk,lv,_,lr} = leftmost(r)
    {lk,lv,l,add(r, lr)}
  end
  def remove(_, _) do {:error, :failtofind} end

  def leftmost({k,v,nil,r}) do {k,v,nil,r} end
  def leftmost({_,_,l,_}) do leftmost(l) end
end
