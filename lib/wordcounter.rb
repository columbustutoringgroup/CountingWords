require 'delegate'

class WordHistogram < SimpleDelegator
  def initialize(*args)
    super(Hash.new(0, *args))
  end

  def to_pretty_s
    word_freq_pairs = self.sort_histogram

    word_lengths = word_freq_pairs.map { |word, _| word }.map &:length
    max_length = word_lengths.max

    self.to_table_s(word_freq_pairs, middle_column_width: max_length)
  end

  protected
  def sort_histogram
    self.sort do |pair1, pair2|
      word1, freq1 = *pair1
      word2, freq2 = *pair2

      next freq2 <=> freq1 unless freq2 == freq1
      word1 <=> word2
    end
  end

  def to_table_s(pairs, left_column_width: 3, middle_column_width: 10, right_column_width: 3)
    rank = 0
    last_freq = nil

    lines = pairs.map do |pair|
      word, freq = *pair

      unless freq == last_freq
        rank += 1
        last_freq = freq
      end

      "%-#{left_column_width}d: %-#{middle_column_width}s %-#{right_column_width}d"% [rank, word, freq]
    end
    lines.join "\n"
  end

end

class WordCounter
  def count(text, ignorecase: true)
    # @type [Array<String>]
    histogram = WordHistogram.new
    words = cleanse(text).scan(/\b[A-Za-z]+\b/)

    words.map! &:downcase if ignorecase
    words.each { |word| histogram[word.to_sym] += 1 }

    histogram
  end

  def count_file(file, ignorecase: true)
    if file.is_a? String
      count File.read(file), ignorecase: ignorecase
    else
      content = file.readlines.join "\n"
      count content, ignorecase: ignorecase
    end
  end

  private
  def cleanse(text)
    cleaners = [
        :drop_conjunctions,
        :drop_nonwords,
        :drop_word_joiners,
    ].map { |sym| method(sym) }

    cleaners.reduce(text) { |cur, method| method.call(cur) }
  end

  def drop_nonwords(text)
    text.gsub(/\W/, ' ')
  end

  def drop_word_joiners(text)
    text.gsub(/[-_]/, ' ')
  end

  def drop_conjunctions(text)
    text.gsub(/\b(\w+)'(\w+)\b/, '\1\2')
  end
end

# puts 'RANK | WORD | FREQUENCY'
# puts WordCounter.new.count_file(__FILE__, ignorecase: true).to_pretty_s
