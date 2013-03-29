require "avrb/assembler"
require "avrb/obj"

module AVRB
  def self.assemble(source)
    o = Obj.new
    assembler = Assembler.new(o)
    assembler << source
    o
  end
end

