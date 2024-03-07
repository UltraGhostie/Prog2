defmodule Toolbox do
  import Bitwise
  def read(file) do
    {:ok, file} = File.open(file, [:read, :utf8])
    binary = IO.read(file, :all)
    File.close(file)
    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, list, _} ->
        list
      list ->
        list
    end
  end

  def bin_to_string integer do
    case integer&&&0b1 do
      0b1 ->
        bin_to_string(integer>>>1, "1")
      _ ->
        bin_to_string(integer>>>1, "0")
    end
  end
  def bin_to_string 0, string do
    string
  end
  def bin_to_string integer, string do
    case integer&&&0b1 do
      0b1 ->
        bin_to_string(integer>>>1, "1"<>string)
      _ ->
        bin_to_string(integer>>>1, "0"<>string)
    end
  end
end
