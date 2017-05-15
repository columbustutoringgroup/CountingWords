class WordCounter
  def initialize
  end

  def count(text)
    parsed = text.downcase.gsub(/(?:[^\w\s\n'\-]|(?<=[^a-z])\-|\-(?=[^a-z]))+/, '').gsub(/[\n\s]+/, ' ').strip
    words = parsed.split(' ')

    list = {}

    words.each do |word|
      if list.key?(word)
        list[word] += 1
      else
        list[word] = 1
      end
    end

    list.sort_by { |key, value| value * -1 }
  end

  def count_from_file(file)
    text = File.open(file, 'r') { |f| f.read }

    count(text)
  end
end
