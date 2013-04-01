module AVRB
  module Directives
    def _org(address)
      @obj.org(@pc = address)
    end

    def _dw(*args)
      args.each do |w|
        @obj << (w.to_i & 0xFFFF)
        @pc += 1
      end
    end

    def _db(*args)
      args.map! do |arg|
        if arg.respond_to?(:bytes)
          arg.bytes.to_a
        else
          arg
        end
      end
      args.flatten.each_slice(2) do |w|
        _dw(((w[1].to_i & 0xFF) << 8) | (w[0].to_i & 0xFF))
      end
    end
  end
end

