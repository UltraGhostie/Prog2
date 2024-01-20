defmodule Simplify do
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end #
  def simplify_add({:div, {:num, n1}, {:num, n2}}, {:num, n3}) do {:div, {:num, n1+(n2*n3)}, {:num, n2}} end
  def simplify_add({:num, n3}, {:div, {:num, n1}, {:num, n2}}) do {:div, {:num, n1+(n2*n3)}, {:num, n2}} end
  def simplify_add({:mul, {:num, n}, e}, {:num, n}) do simplify({:mul, {:num, n}, {:add, simplify(e), {:num, 1}}}) end
  def simplify_add({:num, 0}, e2) do simplify(e2) end #
  def simplify_add(e1, {:num, 0}) do simplify(e1) end #
  def simplify_add({:num, n}, {:var, v}) do {:add, {:num, n}, {:var, v}} end #
  def simplify_add(e1, e2) do {:add, simplify(e1), simplify(e2)} end #

  def simplify_mul({:div, e1, e2}, {:div, e3, e4}) do simplify({:div, simplify({:mul, e1, e3}), simplify({:mul, e2, e4})}) end
  def simplify_mul(e1, {:mul, {:num, -1}, e2}) do simplify({:mul, {:num, -1}, {:mul, simplify(e1), simplify(e2)}}) end
  def simplify_mul({:mul, e1, e2}, {:div, e3, e4}) do simplify({:div, simplify({:mul, simplify(e1), simplify({:mul, simplify(e2), simplify(e3)})}), simplify(e4)}) end
  def simplify_mul({:mul, e1, {:div, e2, e3}}, {:div, e4, e5}) do simplify({:mul, simplify(e1), simplify({:div, simplify({:mul, simplify(e2), simplify(e4)}), simplify({:mul, simplify(e3), simplify(e5)})})}) end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end #
  def simplify_mul({:num, 0}, _) do {:num, 0} end #
  def simplify_mul({:num, 1}, e2) do e2 end #
  def simplify_mul(e1, {:num, 1}) do e1 end #
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end #
  def simplify_mul({:num, n}, {:mul, e1, e2}) do {:mul, simplify({:mul, {:num, n}, simplify(e1)}), simplify(e2)} end
  def simplify_mul(e1, {:mul, {:num, n}, e2}) do {:mul, simplify({:mul, {:num, n}, simplify(e1)}), simplify(e2)} end
  def simplify_mul(e1, {:var, v}) do {:mul, simplify(e1), {:var, v}} end
  def simplify_mul({:var, v}, e2) do {:mul, simplify(e2), {:var, v}} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do simplify(e1) end
  def simplify_exp(e, {:num, n}) do
    cond do
      n < 0 ->
        simplify({:div, {:num, 1}, simplify({:exp, simplify(e), {:num, n*-1}})})
      true ->
        {:exp, simplify(e), {:num, n}}
    end
  end
  def simplify_exp({:var, v}, {:mul, {:num, -1}, e}) do simplify({:div, {:num, 1}, {:exp, {:var, v}, simplify(e)}}) end
  def simplify_exp(e1, e2) do {:exp, simplify(e1), simplify(e2)} end

  def simplify_div({:mul, e1, e2}, e3) do simplify({:mul, simplify(e1), {:div, simplify(e2), simplify(e3)}}) end
  def simplify_div({:num, n1}, {:num, n2}) do
    cond do
      n1 < 0 ->
        {:mul, {:num, -1}, {:div , {:num, n1*-1}, {:num, n2}}}
      n2 < 0 ->
        {:mul, {:num, -1}, {:div , {:num, n1}, {:num, n2*-1}}}
      true ->
        {:div, {:num, n1}, {:num, n2}}
    end
  end
  def simplify_div({:var, v}, {:num, n2}) do
    cond do
      n2 < 0 ->
        {:mul, {:num, -1}, {:div , {:var, v}, {:num, n2*-1}}}
      true ->
        {:div, {:var, v}, {:num, n2}}
    end
  end
  def simplify_div({:num, n1}, {:var, v}) do
    cond do
      n1 < 0 ->
        {:mul, {:num, -1}, {:div , {:num, n1*-1}, {:var, v}}}
      true ->
        {:div, {:num, n1}, {:var, v}}
    end
  end
  def simplify_div({:div, e1, e2}, e3) do simplify({:div, simplify(e1), {:mul, simplify(e2), simplify(e3)}}) end
  def simplify_div(e1, e2) do {:div, simplify(e1), simplify(e2)} end


  def simplify({:add, e1, e2}) do simplify_add(simplify(e1), simplify(e2)) end #
  def simplify({:mul, e1, e2}) do simplify_mul(simplify(e1), simplify(e2)) end #
  def simplify({:div, e1, e2}) do simplify_div(simplify(e1), simplify(e2)) end
  def simplify({:exp, e1, e2}) do simplify_exp(simplify(e1), simplify(e2)) end

  def simplify(e) do e end #
end
