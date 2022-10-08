defmodule Huffman do
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def read(file, n) do
    {:ok, fd} = File.open(file, [:read, :utf8])
     binary = IO.read(fd, n)
     File.close(fd)

     length = byte_size(binary)
     case :unicode.characters_to_list(binary, :utf8) do
       {:incomplete, chars, rest} ->
         {chars, length - byte_size(rest)}
       chars ->
         {chars, length}
     end
   end

  def test do
    sample = sample()
    tree = tree(sample)
    #encode = encode_table(tree)
    #decode = decode_table(tree)
    #text = text()
    #seq = encode(text, encode)
  end

  def tree(sample) do
    freq = freq(sample)
    order = order(freq)
    hufftree(order)
  end
##################################
# to_charlist("hello") -> charlist : [104 , 101 , 322 , 322 , 111]
# [?h, ?e, ?l, ?l, ?o] = 'hello' -> charlist
  def freq(sample) do
    freq(sample, [])
  end

  def freq([], freq) do freq end
  def freq([char | rest], freq) do freq(rest , chfreq(char, freq)) end

  def chfreq(char , []) do [{char,1}] end
  def chfreq(char , [{c, num} | t]) do
    case char == c do
      true -> [{c, num+1} | t]
      false -> [{c, num} | chfreq(char , t)]
    end
  end
####################################
  def order(list) do
    Enum.sort(list , fn({_ ,n},{_,b}) -> n < b end)
  end
  def hufftree([{char , _}]) do char end
  def hufftree([]) do [] end
  def hufftree([{char1, num1},{char2, num2}| tail]) do
    hufftree(order([{{char1, char2}, num1 + num2} | tail]))
  end
####################################
  #[{char , path}, {char , path}....]
  def encode([], _), do: []
  def encode([char | rest], table) do
    { _ , bin } = List.keyfind(table, char, 0)
    bin ++ encode(rest, table)
  end
  # left = {{a,n},{b,n}}, right{{c,n},{d,n}}
  def encode_table(tree) do
    encode_table(tree , [])
  end
  def encode_table({left , right}, path) do
    encode_table(left , path ++ [0]) ++ encode_table(right, path ++ [1])
  end
  def encode_table(char, path) do
    [{char , path}]
  end
###################################
  def decode_table(tree) do encode_table(tree, []) end
  def decode([], _) do [] end
  def decode(bin , table) do
    {char, rest} = decode_char(bin , 1, table)
    [char | decode(rest, table)]
  end
  def decode_char(bin, n, table) do
    {code, rest} = Enum.split(bin , n)
    case List.keyfind(table, code, 1) do
      {char, _ } -> {char, rest};
      nil -> decode_char( bin, n + 1, table)
    end
  end

  def bench(file, n) do
    {text, b} = read(file, n)
    c = length(text)
    {tree, t2} = time(fn -> tree(text) end)
    {encode, t3} = time(fn -> encode_table(tree) end)
    s = length(encode)
    {decode, _} = time(fn -> decode_table(tree) end)
    {encoded, t5} = time(fn -> encode(text, encode) end)
    e = div(length(encoded), 8)
    r = Float.round(e / b, 3)
    {_, t6} = time(fn -> decode(encoded, decode) end)

    IO.puts("text of #{c} characters")
    IO.puts("tree built in #{t2} ms")
    IO.puts("table of size #{s} in #{t3} ms")
    IO.puts("encoded in #{t5} ms")
    IO.puts("decoded in #{t6} ms")
    IO.puts("source #{b} bytes, encoded #{e} bytes, compression #{r}")
  end
  # Measure the execution time of a function.
  def time(func) do
    initial = Time.utc_now()
    result = func.()
    final = Time.utc_now()
    {result, Time.diff(final, initial, :microsecond)/1000}
  end

end
