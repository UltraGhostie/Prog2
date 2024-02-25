defmodule Waiter do
  def start number \\ 5 do
    spawn_link(fn -> init(number) end)
  end

  def quit pid do
    IO.puts("Waiter leaves")
    send(pid, :quit)
  end

  defp init number do
    wait(number)
  end

  defp wait max, eating \\ [] do
    receive do
      {:request, philosopher, number} ->
        case Enum.all?(eating, fn x -> !(abs(x-number) == 1 || abs(x-number) == max-1) end) do
          true ->
            send(philosopher, :ack)
            wait(max, eating++[number])
          false ->
            send(philosopher, :nay)
            wait(max, eating)
        end
      {:done, number} ->
        wait(max, eating--[number])
      :quit ->
        :ok
    end
  end
end
