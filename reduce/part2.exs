defmodule Part2 do

  def map [], _ do [] end
  def map [head|tail], function do
      [function.(head)|map(tail, function)]
  end


  def reducel [], accumulator, _ do accumulator end
  def reducel [head|tail], accumulator, function do
    reducel(tail, function.(head, accumulator), function)
  end

  def reducer [], accumulator, _ do accumulator end
  def reducer [head|tail], accumulator, function do
    accumulated = reducer(tail, accumulator, function)
    function.(head, accumulated)
  end

  def filter [], _ do [] end
  def filter [head|tail], filter do
    case filter.(head) do
      true ->
        [head|filter(tail, filter)]
      _ ->
        filter(tail, filter)
    end
  end

  def filter2 [], _ do [] end
  def filter2 [head|tail], filter do
    tail = filter2(tail, filter)
    head = if filter.(head), do: [head], else: []
    head ++ tail
  end

  def filter3 [], _ do [] end
  def filter3 list, filter do
    reducel(list, [], fn x, y -> if filter.(x), do: [x|y], else: y end)
  end

  def rlength list do
    reducel(list, 0, fn _, y -> y+1 end)
  end

  def even list do
    filter(list, fn x -> rem(x,2) == 0 end)
  end
  def odd list do
    filter2(list, fn x -> rem(x,2) == 1 end)
  end
  def even2 list do
    filter3(list, fn x -> rem(x,2) == 0 end)
  end
  def prime list do
    filter(list, fn x -> is_prime(x) end)
  end
  def is_prime number do
    case number do
      1 ->
        true
      2 ->
        false
      3 ->
        true
      _ ->
        range = Enum.to_list(2..trunc(:math.sqrt(number)))
        filtered = filter(range, fn x -> rem(number,x) != 0 end)
        rlength(range) == rlength(filtered)
    end
  end
  def sum1 list do
    reducer(list, 0, fn x, y -> x+y end)
  end
  def sum2 list do
    reducel(list, 0, fn x, y -> x+y end)
  end
  def inc list, increment do
    map(list, fn x -> x+increment end)
  end
  def dec list, decrement do
    map(list, fn x -> x-decrement end)
  end
  def mul list, multiplier do
    map(list, fn x -> x*multiplier end)
  end
  def square_sum list do
    map(list, fn x -> x*x end)
    |> sum1()
  end
  def square_sum2 list do
    reducer(list, 0, fn x, y -> (x*x)+y end)
  end
end
