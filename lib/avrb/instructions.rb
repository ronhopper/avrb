module AVRB
  module Instructions
    def add(rd, rr);       _op_rd_rr(0x0C00, rd, rr);     end
    def adc(rd, rr);       _op_rd_rr(0x1C00, rd, rr);     end
    def adiw(rdiw, k6);    _op_rdiw_k6(0x9600, rdiw, k6); end
    def sub(rd, rr);       _op_rd_rr(0x1800, rd, rr);     end
    def subi(rdi, k8);     _op_rdi_k8(0x5000, rdi, k8);   end
    def sbc(rd, rr);       _op_rd_rr(0x0800, rd, rr);     end
    def sbci(rdi, k8);     _op_rdi_k8(0x4000, rdi, k8);   end
    def sbiw(rdiw, k6);    _op_rdiw_k6(0x9700, rdiw, k6); end
    def and(rd, rr);       _op_rd_rr(0x2000, rd, rr);     end
    def andi(rdi, k8);     _op_rdi_k8(0x7000, rdi, k8);   end
    def or(rd, rr);        _op_rd_rr(0x2800, rd, rr);     end
    def ori(rdi, k8);      _op_rdi_k8(0x6000, rdi, k8);   end
    def eor(rd, rr);       _op_rd_rr(0x2400, rd, rr);     end
    def com(rd);           _op_rd(0x9400, rd);            end
    def neg(rd);           _op_rd(0x9401, rd);            end
    def sbr(rd, k8);       self.ori(rd, k8);              end
    def cbr(rd, k8);       self.andi(rd, ~k8 & 0xFF);     end
    def inc(rd);           _op_rd(0x9403, rd);            end
    def dec(rd);           _op_rd(0x940A, rd);            end
    def tst(rd);           self.and(rd, rd);              end
    def clr(rd);           self.eor(rd, rd);              end
    def ser(rd);           self.ldi(rd, 0xFF);            end

    def rjmp(o12);         _op_o12(0xC000, o12);          end
    def ijmp;              _dw(0x9409);                   end
    def rcall(o12);        _op_o12(0xD000, o12);          end
    def icall;             _dw(0x9509);                   end
    def ret;               _dw(0x9508);                   end
    def reti;              _dw(0x9518);                   end
    def cpse(rd, rr);      _op_rd_rr(0x1000, rd, rr);     end
    def cp(rd, rr);        _op_rd_rr(0x1400, rd, rr);     end
    def cpc(rd, rr);       _op_rd_rr(0x0400, rd, rr);     end
    def cpi(rdi, k8);      _op_rdi_k8(0x3000, rdi, k8);   end
    def sbrc(rr, b);       _op_rd_b(0xFC00, rr, b);       end
    def sbrs(rr, b);       _op_rd_b(0xFE00, rr, b);       end
    def sbic(io, b);       _op_io_b(0x9900, io, b);       end
    def sbis(io, b);       _op_io_b(0x9B00, io, b);       end
    def brbs(b, o7);       _op_b_o7(0xF000, b, o7);       end
    def brbc(b, o7);       _op_b_o7(0xF400, b, o7);       end
    def breq(o7);          self.brbs(1, o7);              end
    def brne(o7);          self.brbc(1, o7);              end
    def brcs(o7);          self.brbs(0, o7);              end
    def brcc(o7);          self.brbc(0, o7);              end
    def brsh(o7);          self.brbc(0, o7);              end
    def brlo(o7);          self.brbs(0, o7);              end
    def brmi(o7);          self.brbs(2, o7);              end
    def brpl(o7);          self.brbc(2, o7);              end
    def brge(o7);          self.brbc(4, o7);              end
    def brlt(o7);          self.brbs(4, o7);              end
    def brhs(o7);          self.brbs(5, o7);              end
    def brhc(o7);          self.brbc(5, o7);              end
    def brts(o7);          self.brbs(6, o7);              end
    def brtc(o7);          self.brbc(6, o7);              end
    def brvs(o7);          self.brbs(3, o7);              end
    def brvc(o7);          self.brbc(3, o7);              end
    def brie(o7);          self.brbs(7, o7);              end
    def brid(o7);          self.brbc(7, o7);              end

    def mov(rd, rr);       _op_rd_rr(0x2C00, rd, rr);     end
    def movw(rdw, rrw);    _op_rdw_rrw(0x0100, rdw, rrw); end
    def ldi(rdi, k8);      _op_rdi_k8(0xE000, rdi, k8);   end
    def lds(rd, k16);      _op_rd_k16(0x9000, rd, k16);   end
    def ld(rd, i);         _op_rd_ixyz(0x8000, rd, i);    end
    def ldd(rd, i);        _op_rd_iyz(0x8000, rd, i);     end
    def sts(k16, rr);      _op_rd_k16(0x9200, rr, k16);   end
    def st(i, rr);         _op_rd_ixyz(0x8200, rr, i);    end
    def std(i, rr);        _op_rd_iyz(0x8200, rr, i);     end
    def lpm(rd=r0, i=nil); _op_rd_iz(0x9000, rd, i);      end
    def spm(i=nil);        _op_iz(0x95E8, i);             end
    def in(rd, a);         _op_rd_a(0xB000, rd, a);       end
    def out(a, rr);        _op_rd_a(0xB800, rr, a);       end
    def push(rr);          _op_rd(0x920F, rr);            end
    def pop(rd);           _op_rd(0x900F, rd);            end

    def lsl(rd);           self.add(rd, rd);              end
    def lsr(rd);           _op_rd(0x9406, rd);            end
    def rol(rd);           self.adc(rd, rd);              end
    def ror(rd);           _op_rd(0x9407, rd);            end
    def asr(rd);           _op_rd(0x9405, rd);            end
    def swap(rd);          _op_rd(0x9402, rd);            end
    def bset(b);           _op_b(0x9408, b);              end
    def bclr(b);           _op_b(0x9488, b);              end
    def sbi(io, b);        _op_io_b(0x9A00, io, b);       end
    def cbi(io, b);        _op_io_b(0x9800, io, b);       end
    def bst(rd, b);        _op_rd_b(0xFA00, rd, b);       end
    def bld(rd, b);        _op_rd_b(0xF800, rd, b);       end
    def sec;               self.bset(0);                  end
    def clc;               self.bclr(0);                  end
    def sen;               self.bset(2);                  end
    def cln;               self.bclr(2);                  end
    def sez;               self.bset(1);                  end
    def clz;               self.bclr(1);                  end
    def sei;               self.bset(7);                  end
    def cli;               self.bclr(7);                  end
    def ses;               self.bset(4);                  end
    def cls;               self.bclr(4);                  end
    def sev;               self.bset(3);                  end
    def clv;               self.bclr(3);                  end
    def set;               self.bset(6);                  end
    def clt;               self.bclr(6);                  end
    def seh;               self.bset(5);                  end
    def clh;               self.bclr(5);                  end

    def break;             _dw(0x9598);                   end
    def nop;               _dw(0x0000);                   end
    def sleep;             _dw(0x9588);                   end
    def wdr;               _dw(0x95A8);                   end

  private

    def _op_b(op, b)
      # TODO: warn if b is out of range
      _dw(op | ((b & 7) << 4))
    end

    def _op_b_o7(op, b, o7)
      # TODO: warn if b is out of range
      o7 -= (pc + 1)
      # TODO: raise ArgumentError unless (-64..63).include?(o7)
      _dw(op | ((o7 & 0x7F) << 3) | (b & 7))
    end

    def _op_io_b(op, io, b)
      # TODO: raise ArgumentError unless io.is_a?(IORegister) && io.lower32? # TODO: fix this
      # TODO: warn if b is out of range
      _dw(op | (io.to_i << 3) | (b & 7))
    end

    def _op_iz(op, i)
      # TODO: raise ArgumentError unless i.nil? # TODO: some versions allow z+
      _dw(op)
    end

    def _op_o12(op, o12)
      o12 -= (pc + 1)
      # TODO: raise ArgumentError unless (-2048..2047).include?(o12)
      _dw(op | (o12 & 0xFFF))
    end

    def _op_rd(op, rd)
      # TODO: raise ArgumentError unless rd.general?
      _dw(op | (rd.to_i << 4))
    end

    def _op_rd_a(op, rd, a)
      # TODO: raise ArgumentError unless rd.is_a?(Register)
      # TODO: raise ArgumentError if a < 0 || a > 63
      _dw(op | ((a & 0x30) << 5) | (rd.to_i << 4) | (a & 0xF))
    end

    def _op_rd_b(op, rd, b)
      # TODO: raise ArgumentError unless rd.general?
      # TODO: warn if b is out of range
      _dw(op | (rd.to_i << 4) | (b & 7))
    end

    def _op_rd_ixyz(op, rd, i)
      # TODO: raise ArgumentError unless rd.is_a?(Register)
      # TODO: raise ArgumentError unless [x,x+1,-x,y,y+1,-y,z,z+1,-z].include?(i)
      t = case i.to_i
          when x.to_i then 0x100C
          when y.to_i then 0x0008 | ((i.inc? || i.dec?) ? 0x1000 : 0)
          when z.to_i then ((i.inc? || i.dec?) ? 0x1000 : 0)
          else
            # TODO: Argument Error
          end
      t |= 2 if i.dec?
      t |= 1 if i.inc?
      _dw(op | t | (rd.to_i << 4))
    end

    def _op_rd_iyz(op, rd, i)
      # TODO: raise ArgumentError unless rd.is_a?(Register)
      # TODO: raise ArgumentError if (i < y || i > (y+63)) && (i < z || i > (z+63))
      o6 = i.offset
      _dw(op | ((o6 & 0x20) << 8) | ((o6 & 0x18) << 7) | (rd.to_i << 4) | ((~i.to_i & 2) << 2) | (o6 & 7))
    end

    def _op_rd_iz(op, rd, i)
      # TODO: raise ArgumentError unless rd.is_a?(Register)
      if i.nil?
        # TODO: raise ArgumentError unless rd == R0
        _dw((op & ~2) | 0x5C8 | ((op & 2) << 3))
      elsif i.to_i == z.to_i
        if i.inc?
          _dw(op | (rd.to_i << 4) | 5)
        else
          _dw(op | (rd.to_i << 4) | 4)
        end
      else
        # TODO: raise ArgumentError
      end
    end

    def _op_rd_k16(op, rd, k16)
      # TODO: raise ArgumentError unless rd.is_a?(Register)
      # TODO: raise ArgumentError if k16 < 0 || k16 > 65535
      _dw(op | (rd.to_i << 4), k16)
    end

    def _op_rd_rr(op, rd, rr)
      # TODO: raise ArgumentError unless rd.general? && rr.general?
      _dw(op | ((rr.to_i & 0x10) << 5) | (rd.to_i << 4) | (rr.to_i & 0xF))
    end

    def _op_rdi_k8(op, rdi, k8)
      # TODO: raise ArgumentError unless rdi.is_a?(Register) && rdi.immediate?
      # TODO: warn if k8 is out of range
      _dw(op | ((k8 & 0xF0) << 4) | ((rdi.to_i & 0x0F) << 4) | (k8 & 0xF))
    end

    def _op_rdiw_k6(op, rdiw, k6)
      # TODO: raise ArgumentError unless rdiw.is_a?(Register) && rdiw.immediate_word?
      # TODO: warn if k6 is out of range
      _dw(op | ((k6 & 0x30) << 2) | ((rdiw.to_i & 0x06) << 3) | (k6 & 0xF))
    end

    def _op_rdw_rrw(op, rdw, rrw)
      # TODO: raise ArgumentError unless rd.is_a?(Register) && rd.word?
      # TODO: raise ArgumentError unless rr.is_a?(Register) && rr.word?
      _dw(op | (rdw.to_i << 3) | (rrw.to_i >> 1))
    end
  end
end

