freq = Hash.new(0)
file = File.open("speech.txt")
file.read.downcase.scan(/\b[a-z]{3,16}\b/){|word| freq[word] += 1}
freq = freq.sort_by{|a, b| b}
freq.reverse!
freq.each{|word, freq| puts freq.to_s + " - " + word}
