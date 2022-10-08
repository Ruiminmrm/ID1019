defmodule Color do
    def convert(depth, max) do
        #color(depth, max)
        f = depth / max
    
        # a is [0 - 4.0]
        a = f * 4
    
        # x is [0,1,2,3,4]
        x = trunc(a)
    
        # y is [0 - 255]
        y = trunc(255 * (a - x))
    
        case x do
          0 ->
            # black -> red
            {:rgb, y, 0, 0}
    
          1 ->
            # red -> yellow
            {:rgb, 255, y, 0}
    
          2 ->
            # yellow -> green
            {:rgb, 255 - y, 255, 0}
    
          3 ->
            # green -> cyan
            {:rgb, 0, 255, y}
    
          4 ->
            # cyan -> blue
            {:rgb, 0, 255 - y, 255}
        end
    end
    
   " def color(depth, max) do
        f = depth / max
    
        # a is [0 - 4.0]
        a = f * 4
    
        # x is [0,1,2,3,4]
        x = trunc(a)
    
        # y is [0 - 255]
        y = trunc(255 * (a - x))
    
        case x do
          0 ->
            # black -> red
            {:rgb, y, 0, 0}
    
          1 ->
            # red -> yellow
            {:rgb, 255, y, 0}
    
          2 ->
            # yellow -> green
            {:rgb, 255 - y, 255, 0}
    
          3 ->
            # green -> cyan
            {:rgb, 0, 255, y}
    
          4 ->
            # cyan -> blue
            {:rgb, 0, 255 - y, 255}
        end
    end"
end