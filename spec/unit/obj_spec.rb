require "avrb/obj"

describe AVRB::Obj do
  let(:obj) { AVRB::Obj.new }

  it "outputs an extended segment address and end of file record" do
    obj.to_hex.should == ":020000020000FC\n:00000001FF"
  end

  it "outputs a partial line of bytecode" do
    obj << 0x0123 << 0x4567 << 0x89AB << 0xCDEF
    obj.to_hex.should == ":020000020000FC\n:0800000023016745AB89EFCD38\n:00000001FF"
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
end

