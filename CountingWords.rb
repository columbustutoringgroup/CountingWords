freq = Hash.new(0)
file = File.open("speech.txt")
file.read.downcase.gsub(/[^a-z ]/, " ").scan(/\b[a-z]{1,16}\b/){|word| freq[word] += 1}
# could use .gsub(/[:punct:]/, " ") too remove all special characters, or .gsub(/[^a-z ]/, " ") to remove  everything that is not a through z.

freq = freq.sort_by{|a, b| b}
freq.reverse!
freq.each{|word, freq| puts freq.to_s + " - " + word}
