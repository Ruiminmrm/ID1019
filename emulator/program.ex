defmodule Program do
  def load({:prgm, code, data}) do #load code to code part
                                   #load data to data part
    {data, labels} = endata(data)
    code = encode(code, label)
    {{:code, List.to_tuple(code)}, {:data, Map.new(data)}}
  end

  #########################endata
  def endata(data) do #data = [{:label, :arg}, {:word , 12}]
                      #去label ，取value
    endata(data, 0, [], [])
  end
  def endata([], 0, word, label) do  {words, label} end
  def endata([head | tail], n, word, label) do #去label， 取重要信息
    {n, word, label} = labelfix(head, n, word, label)
    endata(tail, n, word, label)#recursion
  end
  #labelfix bas
  def labelfix({:label, labelname}, n, word, label) do
    {n, words, [{labelname, n} |labe]}#beskriva vilken lbale motsvarar vilken värde
  end
  #labelfix :word---->{[{0,12},{:arg,0}]}
  def labelfix({:word, value}, n, words, label) do
    {n ,words} = {n+4, [{n, value} | words]}
    {n, words, label}
  end

  #########################encode
  def encode(code, label) do #revers the ording of the code---> {:aadi,,},{:sub,,} --> {:sub,,},{:aadi,,}
    {code, n, label} = collect(code , label)
    encode(code, n, [], label)
  end

  def collect(code, label) do
    collect(code, 0, [], label)
  end

  def collect([], n, data, label) do
    {data, n, label}
  end
  def collect([{:label, name}|rest], n, data, labels) do
    collect(rest, n, data, [{name, n} | labels])
  end
  def collect([head|tail], n, data, label) do
    collect(tail, n+4, [head|data], label)
  end
  def encode([], _, data, _) do data end
  def encode([head|rest], n , data, label) do
    encode(rest, n-4, [encode(head, n,label) | data], label)
  end
  def encode (head, address, label) do
    case head do
      {:addi, rt, rs, imm} -> {:addi, rt, rs, imm}
      {:ori, rt, rs, imm} -> {:ori, rt, rs, imm}
      {:lw, rt, rs, imm} -> {:lw, rt, rs, imm}
      {:sw, rt, rs, imm} -> {:sw, rt, rs, imm}
      {:beq,  rs, rt, offs} -> {:beq,  rs, rt, offs}
      {:bne,  rs, rt, offs} -> {:bne,  rs, rt, offs}
      head -> head
    end
  end

  def read_instruction({:code, code}, pc) do
    0 = rem(pc,4)
    elem(code, div(pc,4))
  end

  def read_word({:data, data}, i) do
    0 = rem(i,4)    ## addr must be amultiple of 4
    Map.get(data, i)
  end

  def write_word({:data, data}, i, val) do
    0 = rem(i, 4)   ## addr must be amultiple of 4
    {:data, Map.put(data, i, val)}
  end

  def get ([], i) do :nil end
  def get ([head | tail] , i)
end
