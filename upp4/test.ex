def get_odd([]) do [] end
def get_odd([2 | t]) do [2 | get_odd(t)] end
def get_odd([h | t]) do
  cond do
    rem(h , 2) != 0 ->  [h | get_odd(t)]
    true -> get_odd(t)
  end
end
#############
def prim2(n) do sieve2(prime_list(n), list(n)) end
def prime_list(n) do prim1(n) end
def list(n) do Enum.to_list(2..n) end
def store() do [] end
def append([] , y) do y end
def append([h | t] , y) do
  [h | append(t,y)]
end

def sieve2([], [h | t]= list) do list end
def sieve2([h | t] = prime_list, [head | tail] = list) do sieve2( t , sieve2( h , list , store())) end

def sieve2( _, [] , [h | t] = store ) do store end

def sieve2( prim , [head | tail] , [] = store) when prim == head do sieve2(prim, tail, [prim]) end
def sieve2( prim , [head | tail] , [h | t] = store) when prim == head do sieve2(prim, tail, append(store, [head]))end

def sieve2( prim , [head | tail] , [] = store) when prim != head do
  cond do
    rem(head , prim) != 0 -> sieve2(prim, tail, [head] )
    true -> sieve2(prim , tail , store)
  end
end
def sieve2( prim , [head | tail] , [h | t] = store) when prim != head do
  cond do
    rem(head , prim) != 0 -> sieve2(prim, tail, append(store , [head]))
    true -> sieve2(prim , tail , store)
  end
end
###################

def prim3(n) do sieve3(prime_list(n), list(n)) end

def reverse([]) do [] end
def reverse([head|tail]) do reverse(tail)++[head] end

def sieve3([], [h | t]= list) do list end
def sieve3([h | t] = prime_list, [head | tail] = list) do sieve3( t , sieve3( h , list , store())) end

def sieve3( _, [] , [h | t] = store ) do reverse(store) end

def sieve3( prim , [head | tail] , [] = store) when prim == head do sieve3(prim, tail, [prim]) end
def sieve3( prim , [head | tail] , [h | t] = store) when prim == head do sieve3(prim, tail, [head , h | t]) end

def sieve3( prim , [head | tail] , [] = store) when prim != head do
  cond do
    rem(head , prim) != 0 -> sieve3(prim, tail, [head] )
    true -> sieve3(prim , tail , store)
  end
end
def sieve3( prim , [head | tail] , [h | t] = store) when prim != head do
  cond do
    rem(head , prim) != 0 -> sieve3(prim, tail, [head , h | t])
    true -> sieve3(prim , tail , store)
  end
end
