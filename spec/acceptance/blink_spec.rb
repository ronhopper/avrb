require "avrb"

source = <<END
        rjmp reset

;-----------------------------------------------------------------------------;
pause:
        ldi r22,0
        rcall mpause
        dec r22
        brne pc-2
        ret
mpause: ldi r20,0
        dec r20
        brne pc-1
        ret

;-----------------------------------------------------------------------------;
reset:
        sbi 0x17,0  ; DDRB
loop:   sbi 0x16,0  ; PINB
        rcall pause
        rjmp loop
END

output = <<END
:020000020000FC
:1000000009C060E003D06A95E9F7089540E04A9599
:0C001000F1F70895B89AB09AF4DFFDCF24
:00000001FF
END

describe "a simple blinking program" do
  it "assembles to hex format" do
    obj = AVRB.assemble(source)
    obj.to_hex.should == output.strip
  end
end

