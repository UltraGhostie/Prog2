defmodule Compile do
  import Code
  compile_file("environment/listmap.exs", nil)
  compile_file("environment/treemap.exs", nil)
  compile_file("environment/test.exs", nil)
end
