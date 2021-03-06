require "avrb/assembler"

describe AVRB::Instructions do
  let(:assembler) { AVRB::Assembler.new(obj) }
  let(:obj) { o = []; o.stub(:org); o }

  {
    # arithmetic and logic
    "add r0,r0" => [0x0C00],
    "adc r0,r0" => [0x1C00],
    "adiw r25:r24,0" => [0x9600],
    "sub r0,r0" => [0x1800],
    "subi r16,0" => [0x5000],
    "sbc r0,r0" => [0x0800],
    "sbci r16,0" => [0x4000],
    "sbiw r25:r24,0" => [0x9700],
    "and r0,r0" => [0x2000],
    "andi r16,0" => [0x7000],
    "or r0,r0" => [0x2800],
    "ori r16,0" => [0x6000],
    "eor r0,r0" => [0x2400],
    "com r0" => [0x9400],
    "neg r0" => [0x9401],
    "sbr r16,0" => [0x6000],
    "cbr r16,0xFF" => [0x7000],
    "inc r0" => [0x9403],
    "dec r0" => [0x940A],
    "tst r0" => [0x2000],
    "clr r0" => [0x2400],
    "ser r16" => [0xEF0F],

    # branch
    "rjmp pc+1" => [0xC000],
    "ijmp" => [0x9409],
    "rcall pc+1" => [0xD000],
    "icall" => [0x9509],
    "ret" => [0x9508],
    "reti" => [0x9518],
    "cpse r0,r0" => [0x1000],
    "cp r0,r0" => [0x1400],
    "cpc r0,r0" => [0x0400],
    "cpi r16,0" => [0x3000],
    "sbrc r0,0" => [0xFC00],
    "sbrs r0,0" => [0xFE00],
    "sbic 0,0" => [0x9900],
    "sbis 0,0" => [0x9B00],
    "brbs 0,pc+1" => [0xF000],
    "brbc 0,pc+1" => [0xF400],
    "breq pc+1" => [0xF001],
    "brne pc+1" => [0xF401],
    "brcs pc+1" => [0xF000],
    "brcc pc+1" => [0xF400],
    "brsh pc+1" => [0xF400],
    "brlo pc+1" => [0xF000],
    "brmi pc+1" => [0xF002],
    "brpl pc+1" => [0xF402],
    "brge pc+1" => [0xF404],
    "brlt pc+1" => [0xF004],
    "brhs pc+1" => [0xF005],
    "brhc pc+1" => [0xF405],
    "brts pc+1" => [0xF006],
    "brtc pc+1" => [0xF406],
    "brvs pc+1" => [0xF003],
    "brvc pc+1" => [0xF403],
    "brie pc+1" => [0xF007],
    "brid pc+1" => [0xF407],

    # data transfer
    "mov r0,r0" => [0x2C00],
    "movw r1:r0,r1:r0" => [0x0100],
    "ldi r16,0" => [0xE000],
    "lds r0,0" => [0x9000, 0x0000],
    "ld r0,x" => [0x900C],
    "ld r0,x+" => [0x900D],
    "ld r0,-x" => [0x900E],
    "ld r0,y" => [0x8008],
    "ld r0,y+" => [0x9009],
    "ld r0,-y" => [0x900A],
    "ldd r0,y+0" => [0x8008],
    "ld r0,z" => [0x8000],
    "ld r0,z+" => [0x9001],
    "ld r0,-z" => [0x9002],
    "ldd r0,z+0" => [0x8000],
    "sts 0,r0" => [0x9200, 0x0000],
    "st x,r0" => [0x920C],
    "st x+,r0" => [0x920D],
    "st -x,r0" => [0x920E],
    "st y,r0" => [0x8208],
    "st y+,r0" => [0x9209],
    "st -y,r0" => [0x920A],
    "std y+0,r0" => [0x8208],
    "st z,r0" => [0x8200],
    "st z+,r0" => [0x9201],
    "st -z,r0" => [0x9202],
    "std z+0,r0" => [0x8200],
    "lpm" => [0x95C8],
    "lpm r0,z" => [0x9004],
    "lpm r0,z+" => [0x9005],
    "spm" => [0x95E8],
    "in r0,0" => [0xB000],
    "out 0,r0" => [0xB800],
    "push r0" => [0x920F],
    "pop r0" => [0x900F],

    # bit and bit-test
    "lsl r0" => [0x0C00],
    "lsr r0" => [0x9406],
    "rol r0" => [0x1C00],
    "ror r0" => [0x9407],
    "asr r0" => [0x9405],
    "swap r0" => [0x9402],
    "bset 0" => [0x9408],
    "bclr 0" => [0x9488],
    "sbi 0,0" => [0x9A00],
    "cbi 0,0" => [0x9800],
    "bst r0,0" => [0xFA00],
    "bld r0,0" => [0xF800],
    "sec" => [0x9408],
    "clc" => [0x9488],
    "sen" => [0x9428],
    "cln" => [0x94A8],
    "sez" => [0x9418],
    "clz" => [0x9498],
    "sei" => [0x9478],
    "cli" => [0x94F8],
    "ses" => [0x9448],
    "cls" => [0x94C8],
    "sev" => [0x9438],
    "clv" => [0x94B8],
    "set" => [0x9468],
    "clt" => [0x94E8],
    "seh" => [0x9458],
    "clh" => [0x94D8],

    # mcu control
    "break" => [0x9598],
    "nop" => [0x0000],
    "sleep" => [0x9588],
    "wdr" => [0x95A8]
  }.each do |source, words|
    example source do
      assembler << source
      obj.should == words
    end
  end
end

