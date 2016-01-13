class WordCounter
  attr_reader :filename, :word_hash

  def initialize(filename)
    @filename = filename
    @word_hash = generate_sorted_word_hash
  end

  def count
    @word_hash.each { |key, value| puts "#{key}: #{value}"}
  end

  def generate_sorted_word_hash
    unsorted = Hash.new(0)
    words = generate_word_array
    words.each { |word| unsorted[word] += 1 }
    unsorted.sort_by { |key, value| value }.reverse
  end

  def generate_word_array
    contents = File.open(filename, "r").read
    words = contents.split(/[^a-zA-Z']/)
    words.reject(&:empty?)
  end

end

WordCounter.new("speech.txt").count