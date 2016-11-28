string = IO.read("speech.txt")

remove_newlines = string.gsub(/\s+/, ' ').strip

parsed_text = remove_newlines.split(" ").map do |string|
	string.gsub(/[^a-zA-Z0-9'-]/i, '').downcase
end

word_counts = {}

parsed_text.each do |word|
	if word_counts.key?(word)
		word_counts[word] += 1
	else
		word_counts[word] = 1
	end			
end

sorted_counts = word_counts.sort_by {|_key, value| value}
ascended = sorted_counts.reverse

ascended.each do |pair|
	puts "#{pair[0]}: #{pair[1]}"
end