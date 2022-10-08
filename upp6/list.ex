defmodule Ls do
  #拿list的前n个elem组成list
  def take(_, 0) do [] end
  def take([] , _) do [] end
  def take([h | _], 1) do [h] end
  def take([h | t], n) do [h | take(t, n-1)] end

 ##################
 #去掉前n个elem
  def drop([] , _) do [] end
  def drop(list, 0) do list end
  def drop([_ | t], n) do drop(t, n-1)end

  #################
  def append(list1, list2) do list1++list2 end

  #################

  def member([], _) do :no end
  def member([h | t], x) do
    cond do
      h == x -> :yes
      true -> member(t, x)
    end
  end

  ################
  #x的位置
  def position([], _) do 0 end
  def position([h | t], x) do
    cond do
      h == x -> 1
      h != x -> 1 + position(t , x)
    end
  end
end
