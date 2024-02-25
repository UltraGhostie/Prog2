defmodule Philosopher do
  def start hunger, right_chopstick, left_chopstick, name, controller, strength do
    spawn_link(fn -> philosopher(hunger, right_chopstick, left_chopstick, name, controller, strength) end)
  end

  defp dead do
    dead()
  end

  def philosopher _, left_chopstick, right_chopstick, name, controller, 0 do
    IO.puts("#{name} dies")
    send(controller, :done)
    Chopstick.return(right_chopstick)
    Chopstick.return(left_chopstick)
    dead()
  end
  def philosopher 0, _, _, name, controller, _ do
    IO.puts("#{name} is done")
    send(controller, :done)
  end
  def philosopher hunger, right_chopstick, left_chopstick, name, controller, strength do
    IO.puts("#{name} thinks")
    sleep(10)
    IO.puts("#{name} asked for chopsticks")
    me = self()
    request = spawn_link(fn -> Chopstick.request(left_chopstick, right_chopstick, name, me) end)
    receive do
      :ok ->
        sleep(10)
        IO.puts("#{name} ate")
        Chopstick.return(right_chopstick)
        Chopstick.return(left_chopstick)
        philosopher(hunger-1, right_chopstick, left_chopstick, name, controller, strength)
      after
      10 ->
        send(request, :timeout)
        IO.puts("#{name} hungers")
        philosopher(hunger, right_chopstick, left_chopstick, name, controller, strength-1)
    end
  end

  defp sleep(0) do :ok end
  defp sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end
