require "avrb/registers/register"

module AVRB
  class IndirectRegister < Register
    attr_reader :offset

    def initialize(to_i, direction=nil, offset=nil)
      super(to_i)
      @direction = direction
      @offset = offset
    end

    def -@
      self.class.new(to_i, :dec)
    end

    def +(offset=nil)
      self.class.new(to_i, :inc, offset)
    end

    def dec?
      @direction == :dec
    end

    def inc?
      @direction == :inc
    end
  end
end

