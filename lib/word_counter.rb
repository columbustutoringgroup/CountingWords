class WordCounter
  def self.count_words(words)
    regex = /(\w+[^\W])/
    whole_words = words.downcase.scan(regex).map(&:first)
    whole_words.inject({}) { |h, word|
      h[word] = 0 unless h.has_key? word
      h[word] += 1
      h
    }.sort_by { |word, count| count }.reverse.to_h
  end
end
