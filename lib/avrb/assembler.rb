require "avrb/registers"
require "avrb/directives"
require "avrb/instructions"

module AVRB
  class Assembler
    include Registers
    include Directives
    include Instructions

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

        if line =~ /^\.def\s+/i
          eval(line[1..-1].sub("=", ";") << ";end")
          next
        end

        line[0] = "_" if line[0] == "."
        line.gsub!(/(\w+):(\w+)/) do
          # TODO: raise ArgumentError if eval($1).to_i != (eval($2).to_i + 1)
          $2
        end
        line.gsub!(/(\w+)\+\s*(,|$)/) do
          # TODO: raise ArgumentError if eval($1).to_i != (eval($2).to_i + 1)
          "#$1.+()#$2"
        end

        begin
          eval("self.#{line}") if line != ""
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
  end
end

