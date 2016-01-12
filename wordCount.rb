class WordCounter
  attr_accessor :file, :input, :output
  def initialize(file)
    @file = file
    @input = ""
    @output =  Hash.new(0)
  end

  def parse
    File.foreach(@file) {|x| count(x)}
  end

  def print
    @output = @output.sort_by {|key, value| value}
    @output.each {|key, value| puts "#{value} - #{key}"}
  end

  private
  def count(input)
    input = input.split
    input.each do |word|
      @output[word] += 1
    end
  end
end

program = WordCounter.new("speech.txt")
program.parse
program.print