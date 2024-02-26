defmodule PPMGenerator do
  def generate_ppm(rows) when is_list(rows) and length(rows) > 0 do
    width = length(Enum.at(rows, 0))
    height = length(rows)

    header = "P3\n#{width} #{height}\n255\n"
    pixel_data = rows
                |> Enum.map(&format_row/1)
                |> Enum.join(" ")

    header <> pixel_data
  end

  defp format_row(row) when is_list(row) do
    row
    |> Enum.map(&format_color/1)
    |> Enum.join(" ")
  end

  defp format_color({r, g, b}) when is_integer(r) and is_integer(g) and is_integer(b) do
    "#{r} #{g} #{b}"
  end
end
