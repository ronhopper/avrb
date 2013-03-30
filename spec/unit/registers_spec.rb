require "avrb/registers"

class MyRegistersContext
  include AVRB::Registers
end

describe "registers" do
  let(:context) { MyRegistersContext.new }

  it "defines the general purpose registers" do
    r = AVRB::Registers::R0
    context.instance_eval("R0").should be(r)
    context.instance_eval("r0").should be(r)
    r = AVRB::Registers::R16
    context.instance_eval("R16").should be(r)
    context.instance_eval("r16").should be(r)
    r = AVRB::Registers::R31
    context.instance_eval("R31").should be(r)
    context.instance_eval("r31").should be(r)
  end

  it "defines the indirect registers" do
    r = AVRB::Registers::X
    context.instance_eval("X").should be(r)
    context.instance_eval("x").should be(r)
    r = AVRB::Registers::Y
    context.instance_eval("Y").should be(r)
    context.instance_eval("y").should be(r)
    r = AVRB::Registers::Z
    context.instance_eval("Z").should be(r)
    context.instance_eval("z").should be(r)
  end

  it "converts a general purpose register to an integer" do
    AVRB::Registers::R1.to_i.should == 1
    AVRB::Registers::R15.to_i.should == 15
    AVRB::Registers::R30.to_i.should == 30
  end

  it "converts an indirect register to an integer" do
    AVRB::Registers::X.to_i.should == 26
    AVRB::Registers::Y.to_i.should == 28
    AVRB::Registers::Z.to_i.should == 30
  end

  it "checks if a register is general" do
    AVRB::Registers::R0.should be_general
    AVRB::Registers::R31.should be_general
    AVRB::Register.new(32).should_not be_general
    AVRB::Registers::Z.should be_general
  end

  it "checks if a register is word aligned" do
    AVRB::Registers::R0.should be_word
    AVRB::Registers::R1.should_not be_word
    AVRB::Registers::R18.should be_word
    AVRB::Registers::R19.should_not be_word
    AVRB::Registers::R30.should be_word
    AVRB::Registers::R31.should_not be_word
    AVRB::Registers::Z.should be_word
  end

  it "checks if a register is able to handle an immediate operand" do
    AVRB::Registers::R0.should_not be_immediate
    AVRB::Registers::R15.should_not be_immediate
    AVRB::Registers::R16.should be_immediate
    AVRB::Registers::R31.should be_immediate
    AVRB::Registers::Z.should be_immediate
  end

  it "checks if a register is able to handle an immediate word operand" do
    AVRB::Registers::R0.should_not be_immediate_word
    AVRB::Registers::R22.should_not be_immediate_word
    AVRB::Registers::R24.should be_immediate_word
    AVRB::Registers::R25.should_not be_immediate_word
    AVRB::Registers::R30.should be_immediate_word
    AVRB::Registers::R31.should_not be_immediate_word
    AVRB::Registers::Z.should be_immediate_word
  end

  it "checks if an indirect register is pre-decrement" do
    r = AVRB::Registers::Z
    r.should_not be_dec
    (-r).should be_dec
    r.+().should_not be_dec
    (r+5).should_not be_dec
  end

  it "checks if an indirect register is post-increment" do
    r = AVRB::Registers::Z
    r.should_not be_inc
    (-r).should_not be_inc
    r.+().should be_inc
    (r+5).should be_inc
  end

  it "checks if an indirect register has an offset" do
    r = AVRB::Registers::Z
    r.offset.should be(nil)
    (-r).offset.should be(nil)
    r.+().offset.should be(nil)
    (r+5).offset.should == 5
  end
end

