module AVRB
  class Register
    attr_reader :to_i

    def initialize(to_i)
      @to_i = to_i
    end

    def general?
      (0..31).include?(to_i)
    end

    def word?
      to_i.even?
    end

    def immediate?
      (16..31).include?(to_i)
    end

    def immediate_word?
      [24, 26, 28, 30].include?(to_i)
    end
  end
end

