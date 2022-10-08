defmodule Primtal do
  def prim1(n) do sieve((Enum.to_list(2..n))) end

  def sieve([]) do [] end
  def sieve([h | t]) do [ h | sieve(for( y <- t, rem( y , h) != 0 , do: y))] end
  ########################################################
  def prim2(n) do sieve2((Enum.to_list(2..n)), 1) end

  def append([] , y) do y end
  def append([h | t] , y) do [h | append(t,y)] end

  def sieve2([h | t] , n) do
    cond do
      n > List.last([h | t]) -> [h | t]
      true -> sieve2([h | t], n+1 ,[])
    end
  end

  def sieve2([h | t], n , []) do sieve2(t, n ,[h]) end
  def sieve2([h | t] , n ,[head | tail] = prim_list) do
    cond do
      n == h -> sieve2(t, n, append(prim_list, [n]))
      rem(h , n) != 0 -> sieve2(t, n, append(prim_list, [h]))
      true -> sieve2(t, n, prim_list)
    end
  end
  def sieve2([], n , [head | tail] = prim_list) do
    sieve2(prim_list, n)
  end


  #######################################################
  def prim3(n) do sieve3((Enum.to_list(2..n)), 1) end

  def reverse([]) do [] end
  def reverse([head|tail]) do reverse(tail)++[head] end

  def sieve3([h | t] , n) when rem(n , 2) == 1 do
    cond do
      n > List.last([h | t]) -> reverse([h | t])
      true -> sieve3([h | t], n+1 ,[])
    end
  end

  def sieve3([h | t] , n) when rem(n , 2) == 0 do
    cond do
      n > List.first([h | t]) -> reverse([h | t])
      true -> sieve3([h | t], n+1 ,[])
    end
  end

  def sieve3([h | t] , n , []) do sieve3(t, n ,[h]) end

  def sieve3([h | t] , n , [head | tail]) do
    cond do
      n == h -> sieve3(t, n, [h , head | tail])
      rem(h , n) != 0 -> sieve3(t, n,  [h , head | tail])
      true -> sieve3(t, n, [head | tail])
    end
  end

  def sieve3([], n , [head | tail]) do sieve3([head | tail], n) end


    ########################

    #:timer.tc(fn -> Primtal.prim1(n) end)
    #:timer.tc(fn -> Primtal.prim2(n) end)
    #:timer.tc(fn -> Primtal.prim3(n) end)
end
