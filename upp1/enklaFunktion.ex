defmodule Test  do
  def double1(n) do
    2 * n
  end
  def celsius(n) do
    (n - 32)/1.8
  end
  def area(x,y) do
    x*y
  end
  def areasquare(x) do
    x*x
  end
  def areacircle(x) do
    :math.pi()*x*x
  end


  def product1(m,n) do
    if m == 0 do
      0
    else
      n + product(m-1,n)
    end
  end

  def product2(m,n) do
    case m do
      0 -> 0
      _ ->  n + product(m-1,n)
    end
  end

  def product(m,n) do
    cond do
      m == 0 -> 0
      m != 0 -> n + product(m-1,n)
    end
  end

  def exp1(x,n) do
    case n do
      0 -> 1
      _ -> product(x,exp(x,n-1))
    end
  end

  def exp(x,n) do
    cond do
      n==1 -> x
      rem(n,2) == 0 -> exp(x,div(n,2))*exp(x,div(n,2))
      rem(n,2) == 1 -> exp(x,n-1)
    end
  end

  def nth(n,[head | tail]) do
    case n do
      0 -> head
      _ -> nth(n-1,tail)
    end
  end

  def len([]) do 0 end
  def len([head | tail]) do 1 + len(tail) end

  def sum([]) do 0 end
  def sum ([head | tail]) do head+sum(tail) end

  def duplicate([]) do [] end
  def duplicate([head | tail]) do
    [ head | [head | duplicate(tail)]]
  end

  def add(x,[]) do [x] end
  def add(x ,[head|tail]) do
    cond do
      x == head -> [head|tail]
      x != head -> [head |add(x,tail)]
    end
  end

  def unique([]) do [] end
  def unique([head | tail]) do
    [head|for(x <- unique(tail),x != head , do: x)]
  end

  def reverse([]) do [] end
  def reverse([head|tail]) do reverse(tail)++[head] end



  def insert(x,[]) do [x] end
  def insert(x,[head|tail]) do
    cond do
      x <= head -> [x,head | tail]
      x > head  -> [head | insert(x,tail)]
    end
  end

  def isort(l) do isort(l,[]) end
  def isort(l ,sorted) do
    case l do
      []->sorted
      [head|tail] -> isort(tail,insert(head,sorted))
    end
  end

  def to_binary(0) do [0] end
  def to_binary(1) do [1] end
  def to_binary(n) do to_binary(div(n, 2))++[rem(n, 2)]
  end

  def member([] , _) do :no end
  def member([h | t], x) do
    cond do
      h == x -> :yes
      true -> member(t, x)
    end
  end
end
