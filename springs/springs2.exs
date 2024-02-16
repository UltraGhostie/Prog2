defmodule Springs2 do
  def goodtime multiplier, iterations do
    {:ok, output} = File.read("springs.txt")
    File.cp("springs.txt", "springs2.txt")
    spring_array = String.split(output, "\n")
    spring_array = Enum.map(spring_array, fn x -> multiply(x, multiplier) end)
    springs = join(spring_array, "\n")
    File.write("springs.txt", springs)
    out = Springs3.testtime(iterations)
    File.write("springs.txt", output)
  end
  def good multiplier do
    {:ok, output} = File.read("springs.txt")
    File.cp("springs.txt", "springs2.txt")
    spring_array = String.split(output, "\n")
    spring_array = Enum.map(spring_array, fn x -> multiply(x, multiplier) end)
    springs = join(spring_array, "\n")
    File.write("springs.txt", springs)
    out = Springs3.test()
    File.write("springs.txt", output)
  end
  def bad multiplier do
    {:ok, output} = File.read("springs.txt")
    File.cp("springs.txt", "springs2.txt")
    spring_array = String.split(output, "\n")
    spring_array = Enum.map(spring_array, fn x -> multiply(x, multiplier) end)
    springs = join(spring_array, "\n")
    File.write("springs.txt", springs)
    out = Springs1.test()
    File.write("springs.txt", output)
  end

  def multiply spring, multiplier do
    {visual, sequence} = Springs1.spring_split(spring)
    visual = Enum.reduce(1..multiplier, "", fn x, y -> join([visual, y], "?") end)
    sequence = Enum.reduce(1..multiplier, "", fn x, y -> join([sequence, y], ",") end)
    visual <> " " <> sequence
  end

  def join [head|tail], char do
    case tail do
      [] ->
        head
      [""] ->
        head
      _ ->
        head <> char <> join(tail, char)
    end
  end
end
