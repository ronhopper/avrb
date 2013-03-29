require "avrb/assembler"

describe AVRB::Assembler do
  let(:assembler) { AVRB::Assembler.new(obj) }
  let(:obj) { [] }

  it "converts an instruction into bytecode" do
    assembler << "rjmp pc" << "rjmp pc"
    assembler << "rjmp 0x3BC" << "rjmp 0x3BC"
    obj.should == [0xCFFF, 0xCFFF, 0xC3B9, 0xC3B8]
  end

  it "ignores comments" do
    assembler << <<-END
      rjmp pc
; this is a full line comment
      ; an indented comment
      rjmp pc ; this is an inline comment
    END
    obj.should == [0xCFFF, 0xCFFF]
  end

  it "handles forward references" do
    def obj.<<(word); self[@i||0] = word; @i = (@i||0) + 1; end
    def obj.org(address); @i = address; end
    assembler << <<-END
      l0: rjmp l1
          rjmp pc
      l1: rjmp l0
    END
    obj.should == [0xC001, 0xCFFF, 0xCFFD]
  end
end

