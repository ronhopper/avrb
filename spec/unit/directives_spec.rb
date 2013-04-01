require "avrb/assembler"
require "avrb/obj"

describe AVRB::Directives do
  let(:assembler) { AVRB::Assembler.new(obj) }
  let(:obj) { AVRB::Obj.new }

  context "code segment" do
    {
      ".dw 1,0x9598,-2" => [0x0001, 0x9598, 0xFFFE],
      ".db 1,0xA1,-2,'c'" => [0xA101, 0x63FE],
      ".db 'hello'" => [0x6568, 0x6C6C, 0x006F],
      ".equ foo = 256-16\nldi r20,foo" => [0xEF40],
      ".equ FOO = 256-16\nldi r20,FOO" => [0xEF40],
      ".def temp = r20\nldi temp,240" => [0xEF40],
      ".def TEMP = r20\nldi TEMP,240" => [0xEF40],
      ".def temp = R20\nldi temp,240" => [0xEF40],
      ".def TEMP = R20\nldi TEMP,240" => [0xEF40],
      ".set foo = 256-16\nldi r20,foo" => [0xEF40],
      ".set FOO = 256-16\nldi r20,FOO" => [0xEF40],
      ".org 4\n.dw 0x1234\n.org 0\n.dw 0x5678" => [0x5678, nil, nil, nil, 0x1234]
    }.each do |source, words|
      example source do
        assembler << source
        obj.send(:words).should == words
      end
    end
  end
end

