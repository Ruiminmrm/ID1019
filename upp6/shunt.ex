defmodule Shunt do
  def split(list, x) do
    pos =  Ls.position(list,x)
    {Ls.take(list, pos - 1), Ls.drop(list, pos)}
  end

  def find( _ , [] ) do [] end
  def find(input, [x | t]) do
    {hs, ts}= split(input , x)
    { ls , _ , _ } = Ls.drop(Move.move([{:one , Enum.count(ts) + 1} ,
                {:two, Enum.count(hs)} ,
                {:one, -Enum.count(ts) + 1} ,
                {:two, -Enum.count(hs)}] , {input, [], []}) , 4)
    [{:one , Enum.count(Ls.append([x],ts))} ,
     {:two, Enum.count(hs)},
     {:one, -Enum.count(Ls.append([x],ts))} ,
     {:two, -Enum.count(hs)} | find(ls ,t)]
  end

  def few( [] , _ ) do [] end
  def few([h | tail] = input, [x | t]) do
    cond do
      h != x ->
        {hs, ts}= split(input , x)
        { ls , _ , _ } = Ls.drop(Move.move([{:one , Enum.count(ts) + 1} ,
                  {:two, Enum.count(hs)} ,
                  {:one, -Enum.count(ts) + 1} ,
                  {:two, -Enum.count(hs)}] , {input, [], []}) , 4)
        [{:one , Enum.count(Ls.append([x],ts))} ,
        {:two, Enum.count(hs)},
        {:one, -Enum.count(Ls.append([x],ts))} ,
        {:two, -Enum.count(hs)} | few(ls ,t)]
      h == x -> few(tail, t)
    end
  end

  def rules([]) do [] end
  def rules([{ _ , n} = move]) do
    case n == 0 do
      true -> []
      false -> move
    end
  end
  def rules(moves) do
    case moves do
      [{_ , 0} | tail] -> rules(tail)
      [{:one, n},{:one, m} | tail]-> rules([{:one, n + m} | tail])
      [{:two, n},{:two, m} | tail]-> rules([{:two, n + m} | tail])
      [{:one, n},{:two, m} | tail] -> [{:one, n} , rules([{:two, m} | tail])]
      [{:two, n},{:one, m} | tail] -> [{:two, n} , rules([{:one, m} | tail])]
    end
  end

  def compress(ms) do
    ns = rules(ms)
    case ns == ms do
      true -> ms
      false ->compress(ns)
    end
  end
end
