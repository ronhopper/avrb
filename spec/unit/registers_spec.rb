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

  it "converts a register to an integer" do
    AVRB::Registers::R1.to_i.should == 1
    AVRB::Registers::R15.to_i.should == 15
    AVRB::Registers::R30.to_i.should == 30
  end

  it "checks if a register is general" do
    AVRB::Registers::R0.should be_general
    AVRB::Registers::R31.should be_general
    AVRB::Register.new(32).should_not be_general
  end

  it "checks if a register is word aligned" do
    AVRB::Registers::R0.should be_word
    AVRB::Registers::R1.should_not be_word
    AVRB::Registers::R18.should be_word
    AVRB::Registers::R19.should_not be_word
    AVRB::Registers::R30.should be_word
    AVRB::Registers::R31.should_not be_word
  end

  it "checks if a register is able to handle an immediate operand" do
    AVRB::Registers::R0.should_not be_immediate
    AVRB::Registers::R15.should_not be_immediate
    AVRB::Registers::R16.should be_immediate
    AVRB::Registers::R31.should be_immediate
  end

  it "checks if a register is able to handle an immediate word operand" do
    AVRB::Registers::R0.should_not be_immediate_word
    AVRB::Registers::R22.should_not be_immediate_word
    AVRB::Registers::R24.should be_immediate_word
    AVRB::Registers::R25.should_not be_immediate_word
    AVRB::Registers::R30.should be_immediate_word
    AVRB::Registers::R31.should_not be_immediate_word
  end
end

