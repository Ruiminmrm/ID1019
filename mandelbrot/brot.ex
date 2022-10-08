defmodule Brot do
    def mandelbrot(c, m) do
        z0 = Cmplx.new(0, 0)
        test(0, z0, c, m)
    end

  #  def test(m, _, _, m) do 0 end
    def test(i, z0, c, m) do
        abs = Cmplx.abs(z0)
        case i == m do
            true -> 0 
            _ -> case abs > 2 do
                    true -> i
                    _ -> z1 = Cmplx.add(Cmplx.sqr(z0), c)
                            test(i+1, z1, c ,m)
                 end
        end
    end
end
