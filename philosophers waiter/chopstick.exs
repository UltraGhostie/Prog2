defmodule Chopstick do
  def start do
    spawn_link(fn -> available() end)
  end

  defp available do
    receive do
      {:request, requester_id} ->
        send(requester_id, :granted)
        gone()
      :quit -> :ok
    end
  end

  defp gone do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end

  defp granted chopstick do
    send(chopstick, {:request, self()})
    receive do
      :granted -> :ok
    end
  end

  def request left_chopstick, right_chopstick do
    grant_left = Task.async(fn -> granted(left_chopstick) end)
    grant_right = Task.async(fn -> granted(right_chopstick) end)
    case Task.await_many([grant_left, grant_right]) do
      _ -> :ok
    end
  end

  def return chopstick do
    send(chopstick, :return)
  end

  def quit chopstick do
    send(chopstick, :quit)
  end
end
