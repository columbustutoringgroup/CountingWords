TEXT = File.read('speech.txt')


class WordCounter
  @@WORDS_REGEX = /\w+[a-z']*\w+/

  def self.solve text
    words = find_words TEXT
    word_freqs = count_words words
    sorted_words = sort_words word_freqs
    print_sorted_word_counts sorted_words
  end

  def self.find_words text
    text.downcase.scan @@WORDS_REGEX
  end

  def self.count_words words_array
    Hash.new(0).tap do |word_count|
      words_array.each { |word| word_count[word] += 1 }
    end
  end

  def self.sort_words words_frequency_hash
    words_frequency_hash.sort_by { |word, count| -count }
  end

  def self.wordcount_print_format word
    "#{word[1]} - #{word[0].capitalize}"
  end

  def self.print_sorted_word_counts sorted_words
    sorted_words.each { |word| puts wordcount_print_format(word) }
  end
end


WordCounter.solve(TEXT)

