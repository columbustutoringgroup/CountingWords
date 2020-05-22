# Open file
theFile = File.open("speech.txt", "r")

# Read in its contents
contents = ""
theFile.each do |line|
	contents += line
end

# Split the contents into an array of words
words = contents.split(" ")

# Clean up the words: all lowercase, no punctuation
words.collect do |w|
	w.downcase!
	w.gsub!(/\W+/, "")
end

# A hash for associating each word in the text with its number of appearances
wordCount = {}

# If a word is already in the hash, increase its count.  Otherwise add it and
# set its value to 1.
words.each do |w|
	wordCount[w] ? wordCount[w] += 1 : wordCount[w] = 1
end

# Delete the entry for the underscore and delete the blank entry
wordCount.delete("")
wordCount.delete("_")

# Sort by count, from highest to lowest
wordCount = wordCount.sort {|a,b| a[1] <=> b[1]}
wordCount.reverse!

# Print
wordCount.each {|key, value| puts "#{value} - #{key}"}
