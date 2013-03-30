module AVRB
  class Register
    attr_reader :to_i

    def initialize(to_i)
      @to_i = to_i
    end

    def general?
      (0..31).include?(to_i)
    end

    def word?
      to_i.even?
    end

    def immediate?
      (16..31).include?(to_i)
    end

    def immediate_word?
      [24, 26, 28, 30].include?(to_i)
    end
  end

  class IndirectRegister < Register
    attr_reader :offset

    def initialize(to_i, direction=nil, offset=nil)
      super(to_i)
      @direction = direction
      @offset = offset
    end

    def -@
      IndirectRegister.new(to_i, :dec)
    end

    def +(offset=nil)
      IndirectRegister.new(to_i, :inc, offset)
    end

    def dec?
      @direction == :dec
    end

    def inc?
      @direction == :inc
    end
  end

  module Registers
    0.upto(31) do |i|
      const_set "R#{i}", Register.new(i)
      define_method "r#{i}" do
        Registers.const_get "R#{i}"
      end
    end

    X = IndirectRegister.new(26)
    Y = IndirectRegister.new(28)
    Z = IndirectRegister.new(30)
    def x; Registers::X; end
    def y; Registers::Y; end
    def z; Registers::Z; end
  end
end

