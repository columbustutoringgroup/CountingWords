count = {}
File.open("speech.txt").each do |line|
	line_arr = line.split(' ')
    line_arr.each do |word|
    	new_word = ""
    	word_arr = word.split('')
    	word_arr.each do |letter|
    		if letter.upcase != letter.downcase
    			new_word += letter.downcase
    		end
    	end
    	if !count[new_word]
    		count[new_word] = 1
    	else
    		count[new_word] += 1
    	end
    end
end
puts count.sort_by {|k, v| v}.reverse
