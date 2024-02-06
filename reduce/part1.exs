defmodule Part1 do
  @spec rlength([integer()]) :: integer()

  def rlength [] do 0 end
  def rlength [head|tail] do
    1 + length(tail)
  end


  @spec even([integer()]) :: [integer()]

  def even [] do [] end
  def even [head|tail] do
    case rem(head, 2) do
      0 ->
        [head|even(tail)]
      _ ->
        even(tail)
    end
  end

  @spec odd([integer()]) :: [integer()]

  def odd [] do [] end
  def odd [head|tail] do
    case rem(head, 2) do
      1 ->
        [head|odd(tail)]
      _ ->
        odd(tail)
    end
  end

  @spec inc([integer()], integer())  :: [integer()]

  def inc [], _ do [] end
  def inc [head|tail], increment do
    [head+increment|inc(tail, increment)]
  end

  @spec sum([integer()]) :: integer()

  def sum [] do 0 end
  def sum [head|tail] do
    head+sum(tail)
  end

  @spec dec([integer()], integer()) :: [integer()]

  def dec [], _ do [] end
  def dec [head|tail], decrement do
    [head-decrement|dec(tail, decrement)]
  end

  @spec mul([integer()], integer()) :: [integer()]

  def mul [], _ do [] end
  def mul [head|tail], multiplier do
    [head*multiplier|mul(tail, multiplier)]
  end
end
