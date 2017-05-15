class WordCount
  attr_accessor :speech
  attr_reader :counted_words

  def load_file(path)
    @speech = File.read(path)
  end

  def parse_words
    @speech.gsub!(/[^0-9a-zA-Z\s]/, '')
    @speech.gsub!(/\s+/, ' ')
    @speech.downcase!.strip!
    @speech = @speech.split(' ')
  end

  def count_words
    @counted_words = Hash.new
    @speech.each do |word|
      if @counted_words.include?(word)
        @counted_words[word] += 1
      else
        @counted_words[word] = 1
      end
    end
  end

  def report
    sorted_words = @counted_words.sort_by { |word, count| -count }
    sorted_words.each do |word, count|
        puts count.to_s + ' - ' + word
    end
  end

  def run
    load_file('speech.txt')
    parse_words
    count_words
    report
  end
end
