file = File.open("speech.txt")
words = []
file.each do |line| 
  words.concat(line.split)
end

counts = Hash.new(0)
words.each do |word| 
  word=word.downcase.gsub(/[^a-z]/,'')
  counts[word]+=1
end

counts = counts.sort_by {|k,v| v}
counts.reverse!
counts.each do |word|
  puts "#{word[0]} - #{word[1]}"
end
