require "avrb/obj"

describe AVRB::Obj do
  let(:obj) { AVRB::Obj.new }

  it "outputs an end of file record" do
    obj.to_hex.should == ":00000001FF"
  end

  it "outputs a partial line of bytecode" do
    obj << 0x0123 << 0x4567 << 0x89AB << 0xCDEF
    obj.to_hex.should == <<-END.strip
:020000020000FC
:0800000023016745AB89EFCD38
:00000001FF
    END
  end

  it "outputs multiple lines of bytecode" do
    5.times { obj << 0x0123 << 0x4567 << 0x89AB << 0xCDEF }
    obj.to_hex.should == <<-END.strip
:020000020000FC
:1000000023016745AB89EFCD23016745AB89EFCD70
:1000100023016745AB89EFCD23016745AB89EFCD60
:0800200023016745AB89EFCD18
:00000001FF
    END
  end

  it "overwrites existing code if there is an overlapping change in origin" do
    obj << 0x0123 << 0x4567 << 0x89AB << 0xCDEF
    obj.org(2)
    obj << 0xCAFE
    obj.to_hex.should == <<-END.strip
:020000020000FC
:0800000023016745FECAEFCDA4
:00000001FF
    END
  end
end

