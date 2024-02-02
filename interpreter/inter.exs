defmodule Inter do
  import Listmap
  import Eager
  def test do



#     seq = [{:match, {:var, :x}, {:atm, :a}},
# {:match, {:var, :f},
# {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
# {:apply, {:var, :f}, [{:atm, :b}]}
# ]

#     IO.inspect(evaluate(seq), label: "Mine")

    seq = [{:match, {:var, :x},
{:cons, {:atm, :a}, {:cons, {:atm, :b}, {:atm, []}}}},
{:match, {:var, :y},
{:cons, {:atm, :c}, {:cons, {:atm, :d}, {:atm, []}}}},
{:apply, {:fun, :append}, [{:var, :x}, {:var, :y}]}
]

IO.inspect(evaluate(seq), label: "Mine")
  end
end
