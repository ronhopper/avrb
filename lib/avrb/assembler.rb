require "avrb/context"

module AVRB
  class Assembler
    def initialize(obj)
      @context = Context.new(obj)
      @obj = obj
      @forward_references = []
    end

    def <<(source)
      source.lines.each do |line|
        process(line)
      end
      @forward_references.each do |address, line|
        @obj.org(context.pc = address)
        process(line)
      end
      self
    end

  private

    attr_reader :context

    def process(line)
      current_line = line.dup
      return unless line = process_comment(line)
      return unless line = process_label(line)
      return unless line = process_registers(line)
      return unless line = process_directives(line)
      return if line == ""
      begin
        context.instance_eval("self.#{line}")
      rescue NameError => e
        @forward_references << [context.pc, line]
        @obj << 0
        context.pc += 1
      end
    rescue => e
      puts "ERROR: #{e}\n#{current_line}"
      raise e
    end

    def process_comment(line)
      line.split(";").first.strip
    end

    def process_label(line)
      return line unless line =~ /^(\w+):/
      eval("def context.#{$1}; #{context.pc}; end")
      line[($1.length+1)..-1].strip
    end

    def process_registers(line)
      line.gsub!(/\b(\w+):(\w+)\b/) do
        # TODO: raise ArgumentError if eval($1).to_i != (eval($2).to_i + 1)
        $2
      end
      line.gsub!(/([xyz])\+\s*(,|$)/i) do
        # TODO: raise ArgumentError if eval($1).to_i != (eval($2).to_i + 1)
        "#$1.+()#$2"
      end
      line
    end

    def process_directives(line)
      if line =~ /^\.def\s/i
        context.instance_eval(line[1..-1].sub("=", ";") << ";end")
        return nil
      elsif line[0] == "."
        line[0] = "_"
      end
      line
    end
  end
end

