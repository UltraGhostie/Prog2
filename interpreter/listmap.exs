defmodule Listmap do
  @type literal() :: {:num, number()} | {:var, atom()} | {:q, number(), number()} | {:atm, atom()}
  @type expr() :: {:add, expr(), expr()}
  |   {:sub, expr(), expr()}
  |   {:mul, expr(), expr()}
  |   {:div, expr(), expr()}
  |   {:cons, expr(), expr()}
  |   literal()
  def new() do [] end

  def add(k, v, l) do add(l, {k,v}) end
  def add([{key,_}|t], {key,val}) do [{key,val}|t] end
  def add([], z) do z end
  def add([h|t], z) do add(t, [h|z]) end
  def add(h, z) do add([], [h|z]) end

  def lookup(_, []) do nil end
  def lookup(key, [{k,v}|t]) do
    case k do
      ^key ->
        {k,v}
      _ ->
        lookup(key, t)
    end
  end
  def lookup(key, {k,v}) do lookup(key, [{k,v}]) end

  def remove([h|t], map) do remove(h, remove(t, map)) end
  def remove(_, []) do [] end
  def remove(key, [{h,v}|t]) do
    case h do
      ^key ->
        t
      _ ->
        [{h,v}|remove(key, t)]
    end
  end
  def remove(key, {k,v}) do remove(key, [{k,v}]) end
  def remove(_, map) do map end

  def closure([], environment) do
    environment
  end
  def closure([variable | variables], environment) do
    case lookup(variable, environment) do
      nil ->
        :error
      _ ->
        closure(variables, environment)
    end
  end

  def arguments([], [], closure) do
    closure
  end
  def arguments([parameter | parameters], [strct | structs], closure) do
    add(parameter, strct, arguments(parameters, structs, closure))
  end
end
