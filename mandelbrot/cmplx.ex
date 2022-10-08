defmodule Cmplx do
    def new(r,i) do
        {:cmplx , r, i}
    end

    def add({:cmplx, a , i1 },{:cmplx, b , i2}) do
        {:cmplx, a + b , i1 + i2}
    end

    def sqr({:cmplx, a , i}) do
        {:cmplx, a * a - i * i , 2 * a * i }
    end

    def abs({:cmplx, a , i}) do
        :math.sqrt(a * a + i * i )
    end
end
