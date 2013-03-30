require "avrb/registers"
require "avrb/directives"
require "avrb/instructions"

module AVRB
  class Context < ::BasicObject
    include Registers
    include Directives
    include Instructions

    attr_accessor :pc

    def initialize(obj)
      @obj = obj
      @pc = 0
    end
  end
end

