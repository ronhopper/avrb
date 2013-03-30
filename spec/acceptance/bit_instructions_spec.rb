require "avrb"

describe "a program that thoroughly uses bit instructions" do
  let(:source) { File.read("spec/assets/bit_instructions.asm") }
  let(:output) { File.read("spec/assets/bit_instructions.hex") }

  it "assembles to hex format" do
    obj = AVRB.assemble(source)
    obj.to_hex.should == output.strip
  end
end

