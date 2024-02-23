defmodule C do
  import Code
  compile_file("chopstick.exs", nil)
  compile_file("philosopher.exs", nil)
  compile_file("dinner.exs", nil)
  compile_file("waiter.exs", nil)
end
