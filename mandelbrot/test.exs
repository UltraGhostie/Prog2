defmodule Test do
  def read do
    {:ok, string} = File.read("small.ppm")
    IO.inspect(string)
  end

  def test do
    demo()
  end

  def demo do
    small(-2.6, 1.2, 1.2)
  end

  def small x0, y0, xn do
    width = 3840
    height = 2160
    depth = 64
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    # PPM.write("small.ppm", image)
    ppm_content = PPMGenerator.generate_ppm(image)
    File.write!("output.ppm", ppm_content)
  end
end
