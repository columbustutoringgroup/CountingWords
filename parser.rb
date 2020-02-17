class TextParser
	attr_reader :text, :word_counts
	def initialize(file)
		@text = IO.read(file)
		@word_counts = {}
	end

	def remove_newlines
		text.gsub(/\s+/, ' ').strip
	end

	def parsed_text
		remove_newlines.split(" ").map do |string|
			string.gsub(/[^a-zA-Z0-9'-]/i, '').downcase
		end
	end

	def count_words
		parsed_text.each do |word|
			if word_counts.key?(word)
				word_counts[word] += 1
			else
				word_counts[word] = 1
			end
		end
	end

	def sorted_counts
		word_counts.sort_by {|_key, value| -value}
	end

	def parse
		count_words
		sorted_counts.each do |pair|
			puts "#{pair[1]} - #{pair[0]}"
		end
	end
end



p = TextParser.new("speech.txt")
p.parse