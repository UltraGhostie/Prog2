defmodule Compile do
  import Code
  compile_file("springs1.exs", nil)
  compile_file("springs2.exs", nil)
  compile_file("springs3.exs", nil)
  compile_file("springs2good.exs", nil)
end
