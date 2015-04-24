class Histogram
  attr_accessor :contents, :result

  def initialize(file_name)
    @contents = File.read(file_name)
    @contents = @contents.gsub(/ *\n+/, ' ').gsub('\'', '').gsub('.', ' ').gsub(/[^a-zA-Z ]/,'').downcase.split
    @result = word_counter
  end

  def word_counter
    result = Hash.new(0)

    @contents.each{ |word| result[word] += 1 }
    result
  end

  def to_s
    string = ""
    @result.sort_by{|k, v| v}.reverse.each{|k,v| string << "#{v} - #{k} \n" }
    string
  end
end

histogram = Histogram.new("speech.txt")
puts histogram