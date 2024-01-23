defmodule Pprint do
  def pprint({:num, n}) do "#{n}" end #
 ######################################################################################
  def pprint({:var, v}) do "#{v}" end #
 ######################################################################################
  def pprint({:mul, {:num, -1}, e2}) do "-#{pprint(e2)}" end
  def pprint({:mul, e1, {:sqrt, e2}}) do "#{pprint(e1)}#{pprint({:sqrt, e2})}" end
  def pprint({:mul, e1, {:cos, e2}}) do "#{pprint(e1)}#{pprint({:cos, e2})}" end
  def pprint({:mul, e1, {:sin, e2}}) do "#{pprint(e1)}#{pprint({:sin, e2})}" end
  def pprint({:mul, e1, {:ln, e2}}) do "#{pprint(e1)}#{pprint({:ln, e2})}" end
  def pprint({:mul, {:num, n}, {:exp, e1, e2}}) do "#{n}#{pprint({:exp, e1, e2})}" end
  def pprint({:mul, {:num, n}, {:var, v}}) do "#{n}#{v}" end
  def pprint({:mul, e1, {:var, v}}) do "(#{pprint(e1)})#{v}" end
  def pprint({:mul, {:var, v}, e2}) do "(#{pprint(e2)})#{v}" end
  def pprint({:mul, {:num, n}, e2}) do "#{n}(#{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "(#{pprint(e1)})*(#{pprint(e2)})" end #
 ######################################################################################
  def pprint({:add, {:var, v}, {:num, n}}) do "#{v}+#{n}" end
  def pprint({:add, {:num, n}, {:var, v}}) do "#{v}+#{n}" end
  def pprint({:add, e1, {:var, v}}) do "(#{pprint(e1)})+#{v}" end
  def pprint({:add, {:var, v}, e2}) do "#{v}+(#{pprint(e2)})" end
  def pprint({:add, e1, {:num, n}}) do "(#{pprint(e1)})+#{n}" end
  def pprint({:add, {:num, n}, e2}) do "(#{pprint(e2)})+#{n}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)})+(#{pprint(e2)})" end
 ######################################################################################
  def pprint({:exp, {:var, v}, {:mul, {:num, -1}, e1}}) do "#{pprint({:div, {:num, 1}, {:exp, {:var, v}, e1}})}" end
  def pprint({:exp, {:var, v}, {:div, {:num, 1}, {:num, 2}}}) do "sqrt(#{v})" end
  def pprint({:exp, {:var, v}, {:div, {:num, n}, {:num, 2}}}) do "sqrt(#{v})^#{n}" end
  def pprint({:exp, {:var, v}, {:div, e2, {:num, 2}}}) do "sqrt(#{v})^(#{pprint(e2)})" end
  def pprint({:exp, e1, {:div, {:num, n}, {:num, 2}}}) do "sqrt(#{pprint(e1)})^#{n}" end
  def pprint({:exp, e1, {:div, e2, {:num, 2}}}) do "sqrt(#{pprint(e1)})^(#{e2})" end
  def pprint({:exp, {:var, v}, {:num, n}}) do "#{v}^#{n}" end
  def pprint({:exp, {:var, v}, e2}) do "#{v}^(#{pprint(e2)})" end
  def pprint({:exp, e1, {:num, n}}) do "(#{pprint(e1)})^#{n}" end
  def pprint({:exp, e1, e2}) do "((#{pprint(e1)})^(#{pprint(e2)}))" end
 ######################################################################################
  def pprint({:div, e1, {:var, v}}) do "(#{pprint(e1)})/#{v}" end
  def pprint({:div, {:var, v}, e2}) do "#{v}/(#{pprint(e2)})" end
  def pprint({:div, {:num, n1}, {:num, n2}}) do "#{n1}/#{n2}" end
  def pprint({:div, e1, {:num, n}}) do "(#{pprint(e1)})/#{n}" end
  def pprint({:div, {:num, n}, e2}) do "#{n}/(#{pprint(e2)})" end
  def pprint({:div, e1, e2}) do "(#{pprint(e1)})/(#{pprint(e2)})" end
 ######################################################################################
  def pprint({:sqrt, e1}) do "sqrt(#{pprint(e1)})" end
  ######################################################################################
  def pprint({:ln, e}) do "ln(#{pprint(e)})" end
 ######################################################################################
  def pprint({:sin, e}) do "sin(#{pprint(e)})" end
  def pprint({:cos, e}) do "cos(#{pprint(e)})" end
end
