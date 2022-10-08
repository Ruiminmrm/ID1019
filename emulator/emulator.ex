defmodule Emulator do

  def run(code, data, out) do
    reg = Register.new()
    run(0, code, reg, data, out)
  end

  def run(pc, code, reg, data, out) do
    next = Program.read_instruction(code, pc)
    case next do
      :halt -> Out.close(out)

      {:out, rs} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        out = Out.put(out, s)
        run(pc, code, reg, mem, out)

      {:add, rd, rs, rt} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s + t)
        run(pc, code, reg, mem, out)

      {:sub, rd, rs, rt} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        reg = Register.write(reg, rd, s - t)
        run(pc, code, reg, mem, out)

      {:addi, rd, rs, imm} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        reg = Register.write(reg, rd, s + imm)
        run(pc, code, reg, mem, out)

      {:lw, rd, rt, offset} ->
        pc = pc + 4
        t = Register.read(reg, rt)
        value = Program.read_word(mem, t + offset)
        reg = Register.write(reg, rd, value)
        run(pc, code, reg, mem, out)

      {:sw, rd, rt, offset} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Register.read(reg, rt)
        value = Program.read_word(mem, t + offset, s)
        run(pc, code, reg, mem, out)

      {:beq, rs, rt, offset} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Resgiter.read(reg, rt)
        cond do
          s == t -> pc + offset
          _ -> pc
        end
        run(pc, code, reg, mem, out)

       {:bne, rs, rt, offset} ->
        pc = pc + 4
        s = Register.read(reg, rs)
        t = Resgiter.read(reg, rt)
        cond do
          s != t -> pc + offset
          _ -> pc
        end
        run(pc, code, reg, mem, out)
    end
  end
end
