defmodule Deriv do
  @type literal() :: {:num, number()} | {:var, atom()} #
  @type expr() :: {:add, expr(), expr()} #
  | {:mul, expr(), expr()} #
  | {:exp, expr(), expr()} #
  | literal() #
  | {:ln, expr()}
  | {:div, expr(), expr()}
  | {:sin, expr()}
  | {:cos, expr()}
  | {:sqrt, expr()}

  def deriv({:num, _}, _) do {:num, 0} end #

  def deriv({:var, v}, v) do {:num, 1} end #
  def deriv({:var, _}, _) do {:num, 0} end #

  def deriv({:mul, e1, e2}, v) do {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}} end #

  def deriv({:add, e1, e2}, v) do {:add, deriv(e1, v), deriv(e2, v)} end #

  def deriv({:exp, {:num, _}, {:num, _}}, v) do {:num, 0} end
  def deriv({:exp, {:var, v}, {:num, n}}, v) do {:mul, {:num, n}, {:exp, {:var, v}, {:add, {:num, n}, {:num, -1}}}} end
  def deriv({:exp, e1, {:num, n}}, v) do {:mul, deriv(e1, v), {:mul, {:num, n}, {:exp, e1, {:add, {:num, n}, {:num, -1}}}}} end
  def deriv({:exp, {:var, v}, e2}, v) do {:mul, e2, {:exp, {:var, v}, {:add, e2, {:num, -1}}}} end

  def deriv({:div, {:num, 1}, e2}, v) do deriv({:exp, e2, {:num, -1}}, v) end
  def deriv({:div, e1, e2}, v) do deriv({:mul, e1, {:div, {:num, 1}, e2}}, v) end
  def deriv({:div, _, _}, v) do {:num, 0} end

  def deriv({:sqrt, e}, v) do {:mul, deriv(e, v), deriv({:exp, e, {:div, {:num, 1}, {:num, 2}}}, v)} end

  def deriv({:ln, e}, v) do {:mul, deriv(e, v), {:div, {:num, 1}, e}} end

  def deriv({:sin, e}, v) do {:mul, deriv(e, v), {:cos, e}} end

  def deriv({:cos, e}, v) do {:mul, {:num, -1}, {:mul, deriv(e, v), {:sin, e}}} end
end
