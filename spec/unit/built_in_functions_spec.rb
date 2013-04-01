require "avrb/assembler"
require "avrb/obj"

describe AVRB::BuiltInFunctions do
  let(:assembler) { AVRB::Assembler.new(obj) }
  let(:obj) { AVRB::Obj.new }

  {
    ".db high(0x1234),low(0x1234),HIGH(0x5678),LOW(0x5678)" => [0x3412, 0x7856]
  }.each do |source, words|
    example source do
      assembler << source
      obj.send(:words).should == words
    end
  end
end

