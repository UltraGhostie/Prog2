defmodule Compile do
  import Code
  compile_file("deriv.exs", nil)
  compile_file("simplify.exs", nil)
  compile_file("pprint.exs", nil)
  compile_file("test.exs", nil)
end
