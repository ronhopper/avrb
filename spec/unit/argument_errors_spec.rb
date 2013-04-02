require "avrb/assembler"

describe "argument errors" do
  let(:assembler) { AVRB::Assembler.new(obj) }
  let(:obj) { o = []; o.stub(:org); o }

  {
    "bset -1" => "Operand out of range (0 <= s <= 7)",
    "bset 8" => "Operand out of range (0 <= s <= 7)",
    "brbs -1,pc" => "Operand out of range (0 <= s <= 7)",
    "brbs 8,pc" => "Operand out of range (0 <= s <= 7)",
    "brbs 0,(pc+1)-65" => "Branch out of range (-64 <= k <= 63)",
    "brbs 0,(pc+1)+64" => "Branch out of range (-64 <= k <= 63)",
    "sbi -1,0" => "I/O out of range (0 <= P <= 31)",
    "sbi 32,0" => "I/O out of range (0 <= P <= 31)",
    "sbi 0,-1" => "Operand out of range (0 <= s <= 7)",
    "sbi 0,8" => "Operand out of range (0 <= s <= 7)",
    "rjmp (pc+1)-2049" => "Relative address out of range (-2048 <= k <= 2047)",
    "rjmp (pc+1)+2048" => "Relative address out of range (-2048 <= k <= 2047)",
    "ldi r15,0" => "Register cannot support an immediate operation",
    "bst r0,-1" => "Operand out of range (0 <= s <= 7)",
    "bst r0,8" => "Operand out of range (0 <= s <= 7)",
    "bst 0,0" => "Operand is not a register",
    "in r0,-1" => "I/O out of range (0 <= P <= 63)",
    "in r0,64" => "I/O out of range (0 <= P <= 63)",
    "in 0,0" => "Operand is not a register",
    "lds r0,-1" => "SRAM out of range (0 <= k <= 65535)",
    "lds r0,65536" => "SRAM out of range (0 <= k <= 65535)",
    "lds 0,0" => "Operand is not a register",
    "ldi r16,-129" => "Constant out of range (-128 <= k <= 255)",
    "ldi r16,256" => "Constant out of range (-128 <= k <= 255)",
    "adiw r30,-1" => "Constant out of range (0 <= k <= 63)",
    "adiw r30,64" => "Constant out of range (0 <= k <= 63)",
    "com 0" => "Operand is not a register",
    "ld 0,x" => "Operand is not a register",
    "ld r0,r0" => "Operand is not an indirect register",
    "ld r0,x+3" => "Register cannot support this operation",
    "ldd 0,z+0" => "Operand is not a register",
    "ldd r0,r0" => "Operand is not an indirect register",
    "ldd r0,x" => "Register cannot support this operation",
    "ldd r0,-z" => "Register cannot support this operation",
    "ldd r0,z+(-1)" => "Displacement out of range (0 <= q <= 63)",
    "ldd r0,z+64" => "Displacement out of range (0 <= q <= 63)",
    "lpm 0,z" => "Operand is not a register",
    "lpm r1" => "Operand is not an indirect register",
    "lpm r1,r1" => "Operand is not an indirect register",
    "lpm r1,x" => "Register cannot support this operation",
    "lpm r1,y" => "Register cannot support this operation",
    "lpm r1,-z" => "Register cannot support this operation",
    "add 0,r0" => "Operand is not a register",
    "add r0,0" => "Operand is not a register",
    "adiw 0,0" => "Operand is not a register",
    "adiw r1:r0,0" => "Register cannot support an immediate word operation",
    "movw r1:r0,0" => "Operand is not a register",
    "movw 0,r1:r0" => "Operand is not a register",
    "movw r1:r0,r2:r1" => "Register cannot support a word operation",
    "movw r2:r1,r1:r0" => "Register cannot support a word operation"
  }.each do |source, message|
    example source do
      expect { assembler << source }.to raise_error(ArgumentError, message)
    end
  end
end

