defmodule Philosopher do
  def start hunger, right_chopstick, left_chopstick, name, controller do
    spawn_link(fn -> philosopher(hunger, right_chopstick, left_chopstick, name, controller) end)
  end

  def dead do
    dead()
  end

  def philosopher hunger, right_chopstick, left_chopstick, name, controller do
    philosopher(hunger, right_chopstick, left_chopstick, name, controller, 1)
  end
  def philosopher _, _, _, name, controller, 0 do
    IO.puts("#{name} dies")
    send(controller, :done)
    dead()
  end
  def philosopher 0, _, _, name, controller, _ do
    IO.puts("#{name} is done")
    send(controller, :done)
  end
  def philosopher hunger, right_chopstick, left_chopstick, name, controller, strength do
    IO.puts("#{name} thinks")
    sleep(3000)
    IO.puts("#{name} asked for right chopstick")
    case Chopstick.request(right_chopstick, 1_000) do
      :ok ->
        IO.puts("#{name} got right chopstick")
        sleep(1500)
        IO.puts("#{name} asked for left chopstick")
        case Chopstick.request(left_chopstick, 1_000) do
          :ok ->
            IO.puts("#{name} got left chopstick")
            sleep(2000)
            IO.puts("#{name} ate")
            Chopstick.return(right_chopstick)
            Chopstick.return(left_chopstick)
            :fail ->
              Chopstick.return(right_chopstick)
              Chopstick.return(left_chopstick)
              philosopher(hunger, right_chopstick, left_chopstick, name, controller, strength-1)
        end
      :fail ->
        Chopstick.return(right_chopstick)
        philosopher(hunger, right_chopstick, left_chopstick, name, controller, strength-1)
    end
    philosopher(hunger-1, right_chopstick, left_chopstick, name, controller)
  end

  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end
