defmodule Eval do
  import Float
  @type literal() :: {:num, number()} | {:var, atom()} | {:q, number(), number()}
  @type expr() :: {:add, expr(), expr()}
  |   {:sub, expr(), expr()}
  |   {:mul, expr(), expr()}
  |   {:div, expr(), expr()}
  |   literal()


  def eval({:q, n, m}, map) do n/m end

  def eval({:num, n}, _) do n end

  def eval({:add, e1, e2}, map) do eval(e1, map)+eval(e2, map) end

  def eval({:sub, e1, e2}, map) do eval(e1, map)-eval(e2, map) end

  def eval({:mul, e1, e2}, map) do eval(e1, map)*eval(e2, map) end

  def eval({:div, e1, e2}, map) do eval(e1, map)/eval(e2, map) end

  def eval({:var, var}, map) do Map.get(map, var) end

  def map(map, {key, val}) do Map.put(map, key, val) end
  def map(map, [h|t]) do map(map(map, h), t) end
  def map(map, _) do map end

  def rationalize(n) do
    {n1, n2} = ratio((n+0.5)-0.5)
    cond do
      n2 == 1 ->
        {:num, n1}
      true ->
        {:q, n1, n2}
    end
  end

  def test(x \\ 2, y \\ 5) do
    map = Map.new()
    map = map(map, {:x, x})
    map = map(map, {:y, y})

    # e = {:add, {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 2}}, {:q, 1,2}} # 2x+2+0.5
    #e = {:mul, {:var, :x}, {:var, :y}} # xy
    e = {:add, {:add, {:div, {:mul, {:var, :y}, {:num, 3}}, {:var, :x}}, {:num, 10}}, {:mul, {:var, :x}, {:var, :y}}}
    # y3/x+10+xy
    n = rationalize(eval(e, map))

  end
end
