file = File.open("speech.txt", "r")
content = file.read
frequency = Hash.new(0)
wordcount = content.split(" ")
wordcount.each do |w|
  w.gsub!(/\W|_/,"")
  frequency[w] += 1
end
frequency = frequency.sort_by {|word,count| count}.reverse
frequency.each do |key,value|
  puts "#{key}:#{value}"
end
file.close
