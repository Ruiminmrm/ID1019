defmodule Mandel do
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
          Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        rows(width, height, trans, depth, [])
    end

    def rows(w, h, tr, depth, rows) do
        case h == 0 do
            true -> rows
            _ -> row = row(w, h, tr, depth, [])
                 rows(w, h - 1, tr, depth, [row | rows])
        end
    end

    def row(w, h, tr, depth, row) do
        case w == 0 do
            true -> row 
            _ -> res = Brot.mandelbrot(tr.(w, h), depth)
                 color = Color.convert(res, depth)
                 row(w - 1, h, tr, depth, [color | row])
        end
    end        
end