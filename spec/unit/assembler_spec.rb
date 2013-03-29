require "avrb/assembler"

describe AVRB::Assembler do
  let(:assembler) { AVRB::Assembler.new(obj) }
  let(:obj) { [] }

  it "converts an instruction into bytecode" do
    assembler << "rjmp pc" << "rjmp pc"
    assembler << "rjmp 0x3BC" << "rjmp 0x3BC"
    obj.should == [0xCFFF, 0xCFFF, 0xC3B9, 0xC3B8]
  end
end

