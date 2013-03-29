module AVRB
  class Register
    attr_reader :to_i

    def initialize(to_i)
      @to_i = to_i
    end

    def word?
      to_i & 1 == 0
    end

    def immediate?
      to_i >= 16
    end

    def immediate_word?
      to_i & 0x19 == 0x18
    end
  end

  module Registers
    0.upto(31) do |i|
      const_set "R#{i}", Register.new(i)
      define_method "r#{i}" do
        Registers.const_get "R#{i}"
      end
    end
  end
end

