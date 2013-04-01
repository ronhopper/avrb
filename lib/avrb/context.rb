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
      singleton_class = class << self; self; end
      singleton_class.instance_variable_set("@instance", self)
    end

    class << self
      def const_missing(name)
        eval("@instance.#{name}")
      end
    end
  end
end

