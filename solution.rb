text = File.read('speech.txt')
words = text.downcase.scan(/\w+[a-z']*\w+/)

words_count = Hash.new(0)
words.each { |word| words_count[word] += 1}
sorted_word_counts = words_count.to_a.sort_by { |word| -word[1] }

sorted_word_counts.each do |word|
  puts "#{word[0].capitalize}  --  #{word[1]}"
end
