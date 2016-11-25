class WordCounter
  def initialize
  end

  def count(text)
    # parsed = /[a-z]+/s.match(text.downcase)
    parsed = text.downcase.gsub(/[^\w\s\n]/, '').gsub(/[\n\s]+/, ' ').strip
    words = parsed.split(' ')

    list = {}

    words.each { |word|
      if list.key?(word)
        list[word] += 1
      else
        list[word] = 1
      end
    }

    list.sort_by { |key, value| value * -1 }
  end
end
