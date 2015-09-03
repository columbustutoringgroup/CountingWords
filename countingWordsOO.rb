class WordCounter
	
	def initialize (file)
		@file = file
	end

	def getContents
		@contents = ""
		File.open(@file, "r").each {|line| @contents += line }
		@contents
	end

	def countWords
		# split the text into an array of words
		@words = @contents.split(" ")

		# remove punctuation, etc.
		@words = @words.collect{|w| w.downcase.gsub( /\W+/, "") }

		# make a hash associating each word with its number of appearances
		@wordCount = {}
		@words.each {|w| @wordCount[w] ? @wordCount[w] += 1 : @wordCount[w] = 1}

		#delete the blank entry and the entry for the underscore
		@wordCount.delete("")
		@wordCount.delete("_")

		#return the hash
		@wordCount
	end

	def makeCountPresentable
		#sort by value, from highest to lowest
		@presentable = @wordCount.sort{|a,b| a[1] <=> b[1]}.reverse

		#format the results as an array of strings
		@presentable.collect {|key,value| "#{value} - #{key}"}
	end

end

#use the above-defined class on speech.txt
a = WordCounter.new("speech.txt")

a.getContents

a.countWords

puts a.makeCountPresentable


