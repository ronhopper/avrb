require "avrb/obj"

module AVRB
  def self.assemble(source)
    Obj.new << 0xCFFF
  end
end

