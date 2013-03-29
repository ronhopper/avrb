require "avrb"

describe "a simple halting program" do
  it "assembles to hex format" do
    obj = AVRB.assemble(SOURCE)
    obj.to_hex.should == OUTPUT
  end
end

SOURCE = <<END
rjmp pc
END

OUTPUT = <<END.strip
:020000020000FC
:02000000FFCF30
:00000001FF
END

