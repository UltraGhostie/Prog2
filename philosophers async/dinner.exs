defmodule Dinner do
  def start(hunger \\ 5), do: spawn(fn -> init(hunger) end)

  def init(hunger) do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    Philosopher.start(hunger, c1, c2, 1, ctrl)
    Philosopher.start(hunger, c2, c3, 2, ctrl)
    Philosopher.start(hunger, c3, c4, 3, ctrl)
    Philosopher.start(hunger, c4, c5, 4, ctrl)
    Philosopher.start(hunger, c5, c1, 5, ctrl)
    wait(5, [c1, c2, c3, c4, c5])
  end

  def wait(0, chopsticks) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
    IO.puts("Done")
    Process.exit(self(), :kill)
  end
  def wait(n, chopsticks) do
    receive do
      :done ->
        IO.puts("#{5-n} are done")
        wait(n - 1, chopsticks)
      :abort ->
        Process.exit(self(), :kill)
    end
  end
end
