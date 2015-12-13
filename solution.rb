TEXT = File.read('speech.txt')

def find_words text
  words_regex = /\w+[a-z']*\w+/
  text.downcase.scan words_regex
end

def count_words words_array
  Hash.new(0).tap do |word_count|
    words_array.each { |word| word_count[word] += 1 }
  end
end

def sort_words words_frequency_hash
  words_frequency_hash.sort_by { |word, count| -count }
end

def wordcount_print_format word
  "#{word[1]} - #{word[0].capitalize}"
end

def print_sorted_word_counts sorted_words
  sorted_words.each { |word| puts wordcount_print_format(word) }
end

words = find_words TEXT
word_freqs = count_words words
sorted_words = sort_words word_freqs
print_sorted_word_counts sorted_words
