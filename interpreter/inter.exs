defmodule Inter do
  import Listmap
  import Eager
  def test do


    seq = [{:match, {:var, :x}, {:atm,:a}},
    {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
    {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
    {:var, :z}]

    IO.inspect(evaluate(seq), label: "\nMatch")

    seq = [{:match, {:var, :x}, {:atm, :a}},
    {:case, {:var, :x},
    [{:clause, {:atm, :b}, [{:atm, :ops}]},
    {:clause, {:atm, :a}, [{:atm, :yes}]}
    ]}
    ]

    IO.inspect(evaluate(seq), label: "\nClause")

    seq = [{:match, {:var, :x}, {:atm, :a}},
    {:match, {:var, :f},
    {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
    {:apply, {:var, :f}, [{:atm, :b}]}
    ]

    IO.inspect(evaluate(seq), label: "\nLambda")

    seq = [{:match, {:var, :x},
    {:cons, {:atm, :a}, {:cons, {:atm, :b}, {:atm, []}}}},
    {:match, {:var, :y},
    {:cons, {:atm, :c}, {:cons, {:atm, :d}, {:atm, []}}}},
    {:apply, {:fun, :append}, [{:var, :x}, {:var, :y}]}
    ]

    IO.inspect(evaluate(seq), label: "\nProgram")
    IO.write("\nDone.\n")
  end
end
