require "avrb/registers/register"
require "avrb/registers/indirect_register"

module AVRB
  module Registers
    0.upto(31) do |i|
      const_set "R#{i}", Register.new(i)
      define_method "r#{i}" do
        Registers.const_get "R#{i}"
      end
    end

    X = IndirectRegister.new(26)
    def x
      Registers::X
    end

    Y = IndirectRegister.new(28)
    def y
      Registers::Y
    end

    Z = IndirectRegister.new(30)
    def z
      Registers::Z
    end
  end
end

