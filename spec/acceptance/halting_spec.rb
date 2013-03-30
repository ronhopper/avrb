require "avrb"

source = <<END
rjmp pc
END

output = <<END.strip
:020000020000FC
:02000000FFCF30
:00000001FF
END

describe "a simple halting program" do
  it "assembles to hex format" do
    obj = AVRB.assemble(source)
    obj.to_hex.should == output.strip
  end
end

