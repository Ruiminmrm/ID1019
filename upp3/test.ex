defmodule Tree do
 def new() do [0, 0 ,0,0] end
 def read([v |_] , 0) do v end
 def read([_|reg] , n) do read(reg, n-1) end
#可以重写成这个样子
 def read(reg, n) do elem(reg, n) end

  def write(reg, 0, _) do reg end
  def write([v0 , _ | reg], l, v1) do [v0, v1 | reg] end
  def write([v0 | reg], n, v) do [v0 | write(reg, n-1,v)] end
#可以重写成这个样子
  def write(reg, 0, _) do reg end
  def write(reg, 0, _) do put_elem(reg, n,v) end #put_elemt gör en copia , för långa listan är bättre , bara copia behöver inte springa runt

def load({:prgm, prgm ,_}) do
   {labels, code} = filter(prgm,0)
   {labels, code, :na}
end
def filter([],_) do ([],[]) end
def filter([{:label, _}|code]) do
  {label, code} = filter(code)
  {[name|labels], code}
end
def filter([instr | code]) do
  {label, code} = filter(code)
  {[name|labels], code}
end
end
