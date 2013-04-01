module AVRB
  class Obj
    LINES_PER_SEGMENT = 0x1000
    WORDS_PER_LINE = 8
    EOF_RECORD = ":00000001FF"

    def initialize
      @address = 0
      @words = []
    end

    def org(address)
      @address = address
    end

    def <<(word)
      words[address] = word
      self.address = address + 1
      self
    end

    def to_hex
      records = []
      address = 0
      words.each_slice(LINES_PER_SEGMENT * WORDS_PER_LINE) do |segment|
        records << esa_record(address)
        segment.each_slice(WORDS_PER_LINE) do |line|
          byte_count = 2 * line.length
          record = [byte_count, address, 0] + line.map!(&:to_i)
          record << checksum(record)
          records << format(record)
          address += byte_count
        end
      end
      records << EOF_RECORD
      records.join("\n")
    end

  private

    attr_accessor :address
    attr_reader :words

    def checksum(record)
      0xFF & -(record.inject(0) { |a, b| a + (b & 0xFF) + (b >> 8) })
    end

    def format(record)
      ":" << record.pack("CnCv#{record.length - 4}C").unpack("H*").join.upcase
    end

    def esa_record(address)
      record = [2, 0, 2, address >> 4]
      record << checksum(record)
      ":" << record.pack("CnCnC").unpack("H*").join.upcase
    end
  end
end

