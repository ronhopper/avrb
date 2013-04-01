module AVRB
  module BuiltInFunctions
    def low(word)
      word & 0xFF
    end
    alias :LOW :low

    def high(word)
      low(word >> 8)
    end
    alias :HIGH :high
  end
end

