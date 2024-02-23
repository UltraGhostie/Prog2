defmodule Philosopher do
  def start hunger, right_chopstick, left_chopstick, name, controller, waiter, number do
    spawn_link(fn -> philosopher(hunger, right_chopstick, left_chopstick, name, controller, waiter, number) end)
  end

  def philosopher 0, _, _, name, controller, waiter, number do
    IO.puts("#{name} is done")
    send(waiter, {:done, number})
    send(controller, :done)
  end
  def philosopher hunger, right_chopstick, left_chopstick, name, controller, waiter, number do
    IO.puts("#{name} thinks")
    sleep(10)
    send(waiter, {:request, self(), number})
    IO.puts("#{name} asks to eat")
    receive do
      :ack ->
        IO.puts("#{name} asked for chopsticks")
        case Chopstick.request(left_chopstick, right_chopstick) do
          :ok ->
            sleep(10)
            IO.puts("#{name} ate")
            Chopstick.return(right_chopstick)
            Chopstick.return(left_chopstick)
            send(waiter, {:done, number})
            philosopher(hunger-1, right_chopstick, left_chopstick, name, controller, waiter, number)
        end
      :nay ->
        philosopher(hunger, right_chopstick, left_chopstick, name, controller, waiter, number)
    end
  end

  defp sleep(0) do :ok end
  defp sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end
