class Counter
  def initialize
    file = File.open("speech.txt", "r")
    words = []

    file.each do |line|
      words.concat(line.split)
    end

    # Initialize a new hash with default key values of 0
    word_count = Hash.new(0)

    words.each do |word|
      # Strip and replace anything that is not a-z
      word = word.downcase.gsub(/[^a-z]/, '')
      word_count[word] += 1
    end

    # Reverse our order, show the most frequently typed words first
    word_count = word_count.sort_by{ |k, v| v}.reverse!
    puts word_count
  end
end

Counter.new
