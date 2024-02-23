defmodule Chopstick do
  def start do
    spawn_link(fn -> available() end)
  end

  defp available do
    receive do
      :return -> available()
      {:request, requester_id, name} ->
        IO.puts("A chopstick is taken")
        me = self()
        send(requester_id, {:granted, me})
        gone(name)
      :quit -> :ok
    end
  end

  defp gone user do
    receive do
      {:request, user} -> gone(user)
      :return ->
        IO.puts("A chopstick is returned")
        available()
      :quit -> :ok
    end
  end

  def request left, right, name, requester do
    me = self()
    send(left, {:request, me, name})
    send(right, {:request, me, name})
    sticks = Enum.reduce(1..2, [], fn _, y ->
      receive do
        {:granted, stick} ->
          y++[stick]
      end
    end)
    receive do
      :timeout ->
        Enum.each(sticks, fn stick -> return(stick) end)
        :ok
    after
      0 ->
        send(requester, :ok)
    end
  end

  def return chopstick do
    send(chopstick, :return)
  end

  def quit chopstick do
    Process.exit(chopstick, :kill)
  end
end
