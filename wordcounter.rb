class Counter

	def countWords(text)
	  text = text.downcase.gsub(/[^a-z' ]/, '') #make lowercase and only keep allowed characters
    raw_words = text.split(" ")
    count = {}

    raw_words.each do |word|
      if !count.key? word
        count[word] = 1
      else
        count[word] += 1
      end
    end

    count.sort_by{ |k, v| -v}
	end

  def printCount(path)
    text = File.open(path) { |line| line.read } #concatenates every line into one string
    countWords(text).each do |word, count|
      puts "#{word} - #{count}"
    end
  end
end
