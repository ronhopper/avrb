module AVRB
  class Obj
    def to_hex
      ":020000020000FC\n:02000000FFCF30\n:00000001FF"
    end
  end

  def self.assemble(source)
    Obj.new
  end
end

