defmodule Register do

  def new do # 32 general purpose register
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  end

  def read(_, 0) do 0 end # nothing to read
  def read(reg, source) do elem(reg, source)end #read source i tuple reg

  def write(_, 0, _) do 0 end # nowhere to place the value
  def write(reg, dest, value) do put_elem(reg, dest, value) end #put value in index dest in tuple reg
end
