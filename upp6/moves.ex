defmodule Move do
  def single({:one, n}, {main, track1, track2}) do
    cond do
    n >= 0 ->
      track1 = Ls.append(Ls.drop(main , Enum.count(main)-n), track1)
      main = Ls.take(main, Enum.count(main)-n)
      {main, track1, track2}
    n < 0 ->
      main = Ls.append(main, Ls.take(track1, n*(-1)))
      track1 = Ls.drop(track1, n*(-1))
      {main, track1, track2}
    end
  end

  def single({:two, n}, {main, track1, track2}) do
    cond do
      n >= 0 ->
        track2 = Ls.append(Ls.drop(main , Enum.count(main)-n), track2)
        main = Ls.take(main, Enum.count(main)-n)
        {main, track1, track2}
      n < 0 ->
        main = Ls.append(main, Ls.take(track2, n*(-1)))
        track2 = Ls.drop(track2, n*(-1))
        {main, track1, track2}
      end
  end

  def move([], state) do state end
  def move([h | t], state) do [state | move(t, single(h, state))] end
end
