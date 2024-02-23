defmodule Dinner do
  def start(hunger \\ 5) do
    ret = self()
    time = 500000
    spawn(fn -> init(hunger, ret) end)
    timer = Process.send_after(ret, :time, time)
    receive do
      :stop ->
        time = time - Process.cancel_timer(timer)
        IO.inspect(time)
    end
end

  def init(hunger, timer) do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    waiter = Waiter.start()
    Philosopher.start(hunger, c1, c2, :arendt, ctrl, waiter, 1)
    Philosopher.start(hunger, c2, c3, :hypatia, ctrl, waiter, 2)
    Philosopher.start(hunger, c3, c4, :simone, ctrl, waiter, 3)
    Philosopher.start(hunger, c4, c5, :elisabeth, ctrl, waiter, 4)
    Philosopher.start(hunger, c5, c1, :ayn, ctrl, waiter, 5)
    wait(5, [c1, c2, c3, c4, c5], waiter, timer)
  end

  def wait(0, chopsticks, waiter, timer) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
    IO.puts("Dinner ends")
    Waiter.quit(waiter)
    send(timer, :stop)
    Process.exit(self(), :kill)
  end
  def wait(n, chopsticks, waiter, timer) do
    receive do
      :done ->
        IO.puts("#{6-n} are done")
        wait(n - 1, chopsticks, waiter, timer)
      :abort ->
        Process.exit(self(), :kill)
    end
  end
end
