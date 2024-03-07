defmodule C do
  import Code
  {:ok, files} = File.ls
  Enum.filter(files, fn x ->
    case List.to_tuple(String.split(x, ".")) do
      {"c", _} -> false
      {"huffman2", "exs"} -> false
      {_, "exs"} -> true
      _ -> false
    end
  end)
  |> Enum.each(fn x -> compile_file(x, nil) end)
end
