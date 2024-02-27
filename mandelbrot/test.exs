defmodule Test do
  import Bitwise
  def write do
    File.write("test.txt", [1])
  end
  def read do
    {:ok, string} = File.read("test.txt")
    IO.inspect(string)
  end

  def test x0, y0, xn, d \\ 64, res \\ 1 do
    demo(x0, y0, xn, d, res)
  end

  def demo x0, y0, xn, d \\ 64, res \\ 1 do
    me = self()
    time = 20*60*1000
    timer = Process.send_after(me, :time, 20*60*1000)
    small(x0, y0, xn, d, res)
    receive do
      :time ->
        IO.puts("20+")
      after
        0 ->
          time = time - Process.cancel_timer(timer)
          IO.inspect(time/1000)
    end

  end

  def small x0, y0, xn, d \\ 64, res \\ 1 do
    width = 1920<<<res
    height = 1080<<<res
    depth = d
    k = (xn - x0) / width
    IO.puts("Calculating mandelbrot")
    image = Mandelcool.mandelbrot(width, height, x0, y0, k, depth)
    IO.puts("Calculated. Generating image...")
    ppm_content = PPMGenerator.generate_ppm(image, width, height)
    File.write!("#{width}x#{height}d#{depth}xn#{xn}x#{x0}y#{y0}.ppm", ppm_content)
    IO.puts("Image: " <> "#{width}x#{height}d#{depth}xn#{xn}x#{x0}y#{y0}.ppm")
  end
end
