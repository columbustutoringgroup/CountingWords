
def word_count(input_file)

	text = IO.read(input_file).gsub(/\W/, ' ').split(' ')
	counter = Hash.new(0)
	text.each {|x| counter[x] += 1 }
	counter = counter.sort_by {|key, value| value }.reverse

end

p word_count("speech.txt")