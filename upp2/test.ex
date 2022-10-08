defmodule Test do
  def num(n) do
    cond do
      n>0 -> :pos
      n<0 -> :neg
    end
  end
end
