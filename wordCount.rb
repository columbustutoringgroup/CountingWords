class WordCounter
  attr_accessor :file, :output
  def initialize(file)
    @file = file
    @output = {}
    self.read
  end

  def read
    File.foreach(@file) {|x| self.count(x)}
    self.print
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
    @output.each {|key, value| puts "#{key} - #{value}"}
  end
end

WordCounter.new("speech.txt")