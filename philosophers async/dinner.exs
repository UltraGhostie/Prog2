defmodule Dinner do
  def start(hunger \\ 5) do
    timer = spawn(fn -> timer() end)
    spawn(fn -> init(hunger, timer) end)
  end
  def timer do
    me = self()
    time = 600*1000
    timer = Process.send_after(me, :end, time)
    receive do
      {:stop, id} ->
        send(id, :ack)
        time = time - Process.cancel_timer(timer)
        IO.puts(time)
      :end ->
        IO.puts("OOT")
        IO.inspect(self())
    end
  end

  def init(hunger, timer) do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    Philosopher.start(hunger, c1, c2, 1, ctrl, hunger)
    Philosopher.start(hunger, c2, c3, 2, ctrl, hunger)
    Philosopher.start(hunger, c3, c4, 3, ctrl, hunger)
    Philosopher.start(hunger, c4, c5, 4, ctrl, hunger)
    Philosopher.start(hunger, c5, c1, 5, ctrl, hunger)
    wait(5, [c1, c2, c3, c4, c5], timer)
  end

  def wait(0, chopsticks, timer) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
    IO.puts("Done")
    me = self()
    send(timer, {:stop, me})
    receive do
      :ack ->
      after
      2_000 ->
    end
    Process.exit(self(), :kill)
  end
  def wait(n, chopsticks, timer) do
    receive do
      :done ->
        IO.puts("#{5-n} are done")
        wait(n - 1, chopsticks, timer)
      :abort ->
        Process.exit(self(), :kill)
    end
  end
end
