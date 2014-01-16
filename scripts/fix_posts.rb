#!/usr/bin/env ruby

require 'fileutils'

def debug?
  ENV["DEBUG"]
end

def debug(line)
  puts "debug: #{line}" if debug?
end

class String
  def gsubcap!(*arg)
    gsub!(*arg) { yield *$~.captures }
  end
end

class Translator
  def self.translate_line(line)
    translations = {
      %r{\s*\*\s+}                      => lambda {"- "},
      %r{"([^"]+)":(\S+[?/A-Za-z0-9])}  => lambda {|s,u|   "[#{s}](#{u})" },
      %r{^%<(.+)%}                      => lambda {|s|     "![Image](#{s})\n{.img_left}" },
      %r{^%>(.+)%}                      => lambda {|s|     "![Image](#{s})\n{.img_right}" },
      %r{^%(.+)%}                       => lambda {|s|     "![Image](#{s})" },
      %r{^h(\d)\.}                      => lambda {|d|     "#" * d.to_i },
      %r{(.?)\*([^*]+)\*(.?)}           => lambda {|b,s,e| "#{b}**#{s}**#{e}" },
      %r{(.?)_([^_]+)_(.?)}             => lambda {|b,s,e| "#{b}*#{s}*#{e}" },
      %r{(.?)@([^@]+)@(.?)}             => lambda {|b,s,e| "#{b}`#{s}`#{e}" },
    }

    translations.each do |regex, lam|
      debug("    Trying #{regex.inspect} on #{line.inspect}")
      line.gsubcap!(regex, &lam)
    end
    return line
  end

  def initialize(contents)
    @rest   = normalize(contents)
    @output = []
  end

  def normalize(input)
    input.split("\n").map {|s| s.sub(/\r$/, "")}
  end

  def translate
    until @rest.empty?
      line = @rest.first
      [Preamble, CodeBlock, BlockQuote].each do |klass|
        debug "Trying #{klass} against #{line.inspect}"
        if klass::START_REGEX.match(line)
          debug "We have a match on #{line.inspect}"
          section, @rest = klass.new(@rest).translate
          @output.concat(section)
          break
        end
      end
      @output << Translator.translate_line(@rest.shift)
    end
  end

  def output
    @output.join("\n")
  end

  class Processor
    def initialize(content)
      @rest = content.to_a
      @section = []
    end

    def process_line(line)
      line
    end

    def process_first_line(line)
      line
    end

    def process_last_line(line)
      line
    end

    def single_line?
      false
    end

    def translate
      first_line = @rest.shift
      unless first_line =~ self.class::START_REGEX
        raise "#{first_line.inspect} does not match #{self.class::START_REGEX.inspect}"
      end

      if single_line?
        debug "  processing #{first_line}"
        @section << process_line(first_line)
        return @section, @rest
      else
        @section << process_first_line(first_line)
        while line = @rest.shift
          debug "  processing #{line}"
          if line =~ self.class::END_REGEX
            @section << process_last_line(line)
            debug "returning #{@section.inspect} and #{@rest.inspect}"
            return @section, @rest
          else
            @section << process_line(line)
          end
        end
      end
    end
  end

  class BlockQuote < Processor
    START_REGEX = /^<blockquote>\s*$/
    END_REGEX   = %r{^</blockquote>\s*$}

    def process_line(line)
      "> #{Translator.translate_line(line)}"
    end

    def process_first_line(line)
      ""
    end

    def process_last_line(line)
      ""
    end
  end

  class CodeBlock < Processor
    START_REGEX = /^@@@.*$/
    END_REGEX   = /^@@@\s*$/

    def process_first_line(line)
      line.sub("@@@", "~~~")
    end

    def process_last_line(line)
      line.sub("@@@", "~~~")
    end
  end

  class Preamble < Processor
    START_REGEX = /^---\s*$/
    END_REGEX   = /^---\s*$/
  end
end

files = ARGV
files.empty? && files = Dir["source/posts/*.textile"]

files.each do |path|
  puts "Translating #{path}"
  translator = Translator.new(File.read(path))
  translator.translate
  new_path = path.sub(".textile", ".markdown")
  if debug?
    puts translator.output
  else
    File.open(new_path, "w") { |file| file << translator.output }
    FileUtils.rm(path)
  end
end

