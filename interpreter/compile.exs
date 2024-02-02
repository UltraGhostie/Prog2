defmodule Compile do
  import Code
  compile_file("listmap.exs", nil)
  compile_file("eager.exs", nil)
  compile_file("inter.exs", nil)
end
