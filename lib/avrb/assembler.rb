require "avrb/registers"
require "avrb/directives"

module AVRB
  class Assembler
    include Registers
    include Directives

    attr_reader :pc

    def initialize(obj)
      @obj = obj
      @pc = 0
      @forward_references = []
    end

    def <<(source)
      source.lines.each do |line|
        line = line.split(";").first.strip

        if line =~ /^(\w+):/
          label = $1
          line = line[label.length+1..-1].strip
          value = pc
          singleton_class.define_method label do
            value
          end
        end
        line[0] = "_" if line[0] == "."

        begin
          eval("self.#{line}")
        rescue NameError => e
          @forward_references << [pc, line]
          @obj << 0
          @pc += 1
        end
      end
      @forward_references.each do |address, line|
        @obj.org(@pc = address)
        eval(line)
      end
      self
    end

    def rjmp(offset)
      @obj << (0xC000 | ((offset - pc - 1) & 0xFFF))
      @pc += 1
    end
  end
end

