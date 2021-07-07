class Counter

  def initialize text
    @text = text
  end

  def count
    str = @text.downcase
    words = []

    # Special case to handle first - detect all cases of ' & ' as a word
    ampersands = str.scan(/ & /).size
    ampersands.times { words << '&' }

    # Remove non-word characters, then split on whitespace to get words
    str.gsub!(/[^a-zA-Z0-9']/, ' ')
    words.concat(str.split)

    # Count occurrences of each word
    counts = Hash.new(0)
    words.each { |w| counts[w] += 1 }
    counts.sort_by { |k, v| v }.reverse
  end
end

text = File.open('speech.txt', 'r').read
counter = Counter.new(text)
counter.count.each { |w| print "#{w[0]} - #{w[1]}\n" }
