class WordCounter
  attr_accessor :file, :input, :output
  def initialize(file)
    @file = file
    @input = ""
    @output = {}
  end

  def parse
    File.foreach(@file) {|x| count(x)}
  end

  def count(input)
    input = input.split
    input.each do |word|
      if @output[word] == nil
        @output[word] = 1
      else
        @output[word] += 1
      end
    end
  end


  def print
    @output = @output.sort_by {|key, value| value}
    @output.each {|key, value| puts "#{value} - #{key}"}
  end
end

program = WordCounter.new("speech.txt")
program.parse
program.print