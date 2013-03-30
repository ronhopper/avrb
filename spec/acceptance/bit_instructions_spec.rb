require "avrb"

describe "a program that thoroughly uses bit instructions" do
  it "assembles to hex format" do
    obj = AVRB.assemble(SOURCE)
    obj.to_hex.should == OUTPUT.strip
  end
end

SOURCE = File.read("spec/assets/bit_instructions.asm")
OUTPUT = File.read("spec/assets/bit_instructions.hex")

