defmodule Parser do
  def parse file do
    parse_file(file)
    |> parse_contents()
  end

  def parse_contents [head|tail] do
    {parse_seeds(head), parse_ranges(tail)}
  end

  def parse_file file do
    {:ok, contents} = File.read(file)
    String.split(contents, "\r\n\r\n")
    |> Enum.map(fn x ->
      [_|tail] = String.split(x, "\r\n")
      tail
    end)
  end

  def parse_seeds seeds do
    Enum.map(seeds, fn x ->
        String.split(x, " ")
        |> Enum.map(fn y ->
          {number, _} = Integer.parse(y)
          number
        end)
      end)
    |> List.flatten()
  end

  def parse_ranges ranges do
    Enum.map(ranges, fn a ->
      Enum.map(a, fn x ->
        split = String.split(x, " ")
        [destination, source, range] = Enum.map(split, fn y ->
          {a, _} = Integer.parse(y)
          a
        end)
        {source..source+range, destination-source}
      end)
    end)
  end
end
