require "avrb"

describe "a program that thoroughly uses alu instructions" do
  it "assembles to hex format" do
    obj = AVRB.assemble(SOURCE)
    obj.to_hex.should == OUTPUT.strip
  end
end

SOURCE = File.read("spec/assets/alu_instructions.asm")
OUTPUT = File.read("spec/assets/alu_instructions.hex")

