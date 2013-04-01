require "avrb"

describe "a program that thoroughly uses general purpose registers" do
  let(:source) { File.read("spec/assets/registers.asm") }
  let(:output) { File.read("spec/assets/registers.hex") }

  it "assembles to hex format" do
    obj = AVRB.assemble(source)
    obj.to_hex.should == output.strip
  end
end


