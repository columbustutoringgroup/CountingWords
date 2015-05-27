class Counter
  def initialize(filename)
    @filename = filename
  end

  # Do everything
  def run
    contents = File.read(@filename)
    word_hash = split_text(contents)
    print_descending(word_hash)
  end

  # Splits the text into a hash of words and counts
  def split_text(text)
    all_words = text.scan(/((?:\w+|\')+)/).flatten.map { |x| x.downcase }

    mapping = Hash.new
    all_words.uniq.map {|x| mapping[x] = all_words.count(x) }
    mapping
  end

  # Prints the hash of words in descending order of count
  def print_descending(word_hash)
    word_hash.sort_by { |key, value| value }.reverse.each { |x, y| puts "#{y} - #{x}" }
  end
end

Counter.new('speech.txt').run
