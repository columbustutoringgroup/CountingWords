class WordCounter
  def self.count_words(words)
    whole_words = words.downcase.scan(/(\w+\b)/).map(&:first)
    whole_words.reduce({}) { |h, word|
      h[word] = 0 unless h.has_key? word
      h[word] += 1
      h
    }.sort_by { |word, count| count }.reverse.to_h
  end
end
