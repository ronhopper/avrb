require "avrb/registers"
require "avrb/directives"
require "avrb/instructions"
require "avrb/built_in_functions"

module AVRB
  class Context < ::BasicObject
    include Registers
    include Directives
    include Instructions
    include BuiltInFunctions

    attr_accessor :pc

    def initialize(assembler, obj)
      @assembler = assembler
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

