class Counter
  attr_accessor :dictionary, :filepath

  def initialize(filepath)
    @filepath = filepath
    @dictionary = {}
  end

  def read
    text_file = File.open(@filepath)
    contents = text_file.read
    words_array = contents.split(' ')
    words_array.map! { |word| word.gsub(/[^a-zA-Z']/, '').downcase }
    words_array.each do |word|
      # check for whitespace characters to prevent adding them to the hash
      word !~ /^\s*$/ && @dictionary.key?(word) ? @dictionary[word] += 1 : @dictionary.store(word, 1)
    end
  end

  def display
    @dictionary.sort_by { |_k, v| v }.reverse!.each do |key, pair|
      puts "#{pair.to_s.rjust(3)} - #{key}"
    end
  end
end

counter = Counter.new('speech.txt')
counter.read
counter.display
