module AVRB
  class Assembler
    attr_reader :pc

    def initialize(obj)
      @obj = obj
      @pc = 0
    end

    def <<(source)
      eval(source)
      self
    end

    def rjmp(offset)
      @obj << (0xC000 | ((offset - pc - 1) & 0xFFF))
      @pc += 1
    end
  end
end

