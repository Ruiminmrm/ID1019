defmodule Out do
  def new do [] end #creat a new output

  def close(out) do Enum.reverse(out) end #???????

  def put(out, val) do [val | out] end # add value at the beginning of the list

end
