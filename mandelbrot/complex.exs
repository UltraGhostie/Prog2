defmodule Complex do
  def new do {0,0} end
  def new r, i do {r,i} end

  def add {ra,ia}, {rb,ib} do {ra+rb,ia+ib} end

  def square {r,i} do {(r*r)-(i*i), (r*i)*2} end

  def abs {r,i} do :math.sqrt((r*r)+(i*i)) end
end
