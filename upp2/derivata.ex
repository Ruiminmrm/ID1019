## (x^n)' = (n)x^(n-1)---done
## (ln(x))' = 1/x---deriv-done, calc-done, simplify-done, simplify_-done, pprint-done
## (1/x)' = (x^(-1))' = -x^-2---deriv-done ,calc-done, simplify-done , simplify_-done, pprint-done
## (sqrt(x))' = (x^0,5)' = kör (x^n)---deriv-done, calc-done, simplify-done, simplify_-done, pprint-done
## (sin(x))' = cos(x)---deriv-done , calc- , simplify- , simplify_- , pprint-
defmodule Deriv do
  @type literal() :: {:num, number()} | {:var, atom()}
  @type expr() :: literal()
        |{:add, expr(), expr()}
        |{:mul, expr(), expr()}
        |{:exp, expr(), literal()}
        |{:sqrt, expr()}#
        |{:div, expr()}#
        |{:log, literal(),expr()}#
        |{:sin, expr()}#

  def deriv({:num, _}, _) do {:num, 0} end ##(num)' = 0
  def deriv({:var, v}, v) do {:num, 1} end ##(varoable)' = 1
  def deriv({:var, _}, _) do {:num, 0} end ##om det variable inte är den som ska deriveras ---> 0
  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2, v)}
  end
  def deriv({:mul, e1, e2}, v) do
    {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
  end
  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n-1 }}}, deriv(e, v)}
  end
######################################sqrt
  def deriv({:sqrt, e}, v) do
    {:mul, {:div, {:mul, {:num, 2}, {:sqrt, e}}}, deriv(e, v)}
  end
######################################1/x
  def deriv({:div, e}, v) do
    {:mul, {:div, {:mul, {:num, -1}, {:exp, e, {:num, 2}}}} , deriv(e, v)}
  end
######################################ln
  def deriv({:log, {:num,n}, e}, v) do
    {:mul, {:div, {:mul, e, {:log, {:num, :math.exp(1)},{:num, n}}}}, deriv(e, v)}
  end
#####################################tri
  def deriv({:sin, e}, v) do
    {:mul, {:cos, e}, deriv(e, v)}
  end
  def deriv({:cos, e}, v) do
    {:mul, {:num, -1},
    {:mul, {:sin, e}, deriv(e, v)}}
  end
#####################################
  def calc({:num, n}, _, _)do {:num, n} end ##(uttryck , variabel, värde av variabel)
  def calc({:var, v}, v, n)do {:num, n} end
  def calc({:var, v}, v, _)do {:var, v} end
  def calc({:add, e1, e2}, v, n)do
    {:add, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:mul, e1, e2}, v, n)do
    {:mul, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:exp, e1, e2}, v, n)do
    {:exp, calc(e1, v, n), calc(e2, v, n)}
  end
#######################################sqrt
  def calc({:sqrt, e}, v, n) do
    {:sqrt, calc(e, v, n)}
  end
#######################################1/x
  def calc({:div, e}, v, n) do
    {:div, calc(e, v, n)}
  end
##########################################ln
  def calc({:log, e1, e2}, v, n) do
    {:exp, calc(e1, v, n), calc(e2, v, n)}
  end
##########################################sin
  def calc({:cos, e}, v, n) do
    {:cos, calc(e, v, n)}
  end
  def calc({:sin, e}, v, n) do
    {:sin, calc(e, v, n)}
  end
##########################################
  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end
  ########################################sqrt
  def simplify({:sqrt, e}) do
    simplify_sqrt(simplify(e))
  end
  ########################################1/x
  def simplify({:div, e}) do
    simplify_div(simplify(e))
  end
  ########################################ln
  def simplify({:log, e1, e2}) do
    simplify_log(simplify(e1), simplify(e2))
  end
  ########################################sin
  def simplify({:cos, e}) do
    simplify_sin(simplify(e))
  end
  def simplify({:sin, e}) do
    simplify_cos(simplify(e))
  end
  ########################################
  def simplify(e) do e end

  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(e1, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1,n2)}end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end
#################################sqrt
  def simplify_sqrt({:num, n}) when n < 0 do IO.puts("error, sqrt(negative number) is undefined") end
  def simplify_sqrt({:num, n}) do {:num, :math.sqrt(n)} end
  def simplify_sqrt(e) do {:sqrt, e} end
####################################1/x
  def simplify_div({:num, 0}) do IO.puts("error, 1/0 is undefined") end
  def simplify_div({:num, n}) do {:num, 1/n} end
  def simplify_div(e) do {:div, e} end
######################################ln
  def simplify_log(_, {:num, n}) when n < 0 do IO.puts("error, undefined") end
  def simplify_log({:num, bas}, _) when bas < 0 do IO.puts("error, undefined") end
  def simplify_log({:num, bas}, {:num, n}) do {:num, :math.log(n)/:math.log(bas)} end
  def simplify_log(e1, e2) do {:log, e1, e2} end
######################################tri
  def simplify_sin({:num, n}) do {:num, :math.cos(n)} end
  def simplify_sin(e) do {:cos, e} end

  def simplify_cos({:num, n}) do {:num, :math.sin(n)} end
  def simplify_cos(e) do {:sin, e} end
######################################
  def test1() do ##2x+4 derivate
    e = {:add,
        {:mul, {:num, 2}, {:var, :x}} ,
        {:num, 4}}
    d = deriv(e, :x)
   # c = calc(d, :x, 5)
    IO.write("expression: #{pprint(e)}\n")##IO.write()--->输出没有双引号的版本， \n---＞new line
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
    #IO.write("calculated: #{pprint(simplify(c))}\n")
    :ok
  end

  def test2() do #2x^2+3x+5 derivate
  e = {:add, {:add, {:mul, {:num, 2}, {:exp, {:var, :x}, {:num, 2}}}, {:mul, {:var, :x}, {:num, 3}}}, {:num, 5}}
  d = deriv(e, :x)
  c = calc(d, :x, 1)
  IO.write("expression: #{pprint(e)}\n")##IO.write()--->输出没有双引号的版本， \n---＞new line
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
  end
###########################sqrt
  def test3() do
   e = {:sqrt, {:var, :x},}
   d = deriv(e, :x)
   c = calc(d, :x, 5)
   IO.write("expression: #{pprint(e)}\n")##IO.write()--->输出没有双引号的版本， \n---＞new line
   IO.write("derivative: #{pprint(d)}\n")
   IO.write("simplified: #{pprint(simplify(d))}\n")
   IO.write("calculated: #{pprint(simplify(c))}\n")
   :ok
  end
###########################div
 def test4() do
  e = {:div,{:var, :x}}
  d = deriv(e, :x)
  c = calc(d, :x, 1)
  IO.write("expression: #{pprint(e)}\n")##IO.write()--->输出没有双引号的版本， \n---＞new line
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
 end
###########################ln
 def test5() do
  e = {:log , {:num, 5}, {:add, {:num, 5}, {:mul, {:num, 2}, {:var, :x}}}}
  d = deriv(e, :x)
  c = calc(d, :x, 1)
  IO.write("expression: #{pprint(e)}\n")##IO.write()--->输出没有双引号的版本， \n---＞new line
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
 end
 ##########################sin
 def test6() do
  e ={:sin, {:var , :x}}
  d = deriv(e, :x)
  c = calc(d, :x, 1)
  IO.write("expression: #{pprint(e)}\n")##IO.write()--->输出没有双引号的版本， \n---＞new line
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")
  IO.write("calculated: #{pprint(simplify(c))}\n")
  :ok
 end

##terminal 里面可以输入"x = #{3+4}"---> output: "x = 7"
  def pprint({:num, n}) do "#{n}" end ## return number
  def pprint({:var, v}) do "#{v}" end ## return var
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end ## return e1 + e2
  def pprint({:mul, e1, e2}) do "#{pprint(e1)} * #{pprint(e2)}" end ## return e1 * e2
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)})^(#{pprint(e2)})" end

  def pprint({:sqrt, e}) do "(#{pprint(e)})^(-0.5))" end
  def pprint({:div, e}) do "(#{pprint({:num, 1})})/(#{pprint(e)})" end
  def pprint({:log, e1, e2}) do "(ln#{pprint(e2)} / ln#{pprint(e1)})" end
  def pprint({:sin, e}) do "(sin(#{pprint((e))}))" end
  def pprint({:cos, e}) do "(cos(#{pprint((e))}))" end
end
