
class Counter
  def initialize(file)
    @file = File.open(file)
    @txt_array = []
  end

  def display
    occurence.each do |x,y|
      puts "#{x}: #{y}"
    end
  end

  def parse
    @file.each do |line|
      line = line.encode('UTF-8', :invalid => :replace)
      @txt_array.push(line.split(" "))
    end
    @txt_array.flatten
  end

  def occurence
    frequency = Hash.new(0)
    parse.each do |word|
      new_word = word.gsub(/[^a-zA-Z]/, "").downcase
      frequency.store(new_word, frequency[new_word]+1)
    end
    Hash[frequency.sort_by{|k,v| v}.reverse].delete("")
  end
end

ex = Counter.new('speech.txt')

# ex.parse
# ex.occurence
ex.display

  