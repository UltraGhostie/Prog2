defmodule Chopstick do
  def start do
    stick = spawn_link(fn -> available() end)
  end

  def available do
    receive do
      {:request, requester_id} ->
        send(requester_id, :granted)
        gone()
      :quit -> :ok
    end
  end

  def gone do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end

  def request chopstick do
    send(chopstick, {:request, self()})
    receive do
      :granted -> :ok
    end
  end
  def request chopstick, time do
    send(chopstick, {:request, self()})
    receive do
      :granted -> :ok
    after
      time -> :fail
    end
  end

  def return chopstick do
    send(chopstick, :return)
  end

  def quit chopstick do
    Process.exit(chopstick, :kill)
  end
end
