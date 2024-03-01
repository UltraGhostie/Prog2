defmodule PPMGenerator do
  def generate_ppm(pixel_data, width, height) do
    header = "P3\n#{width} #{height}\n65535\n"
    header <> pixel_data
  end
end
