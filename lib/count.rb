class Count

	def initialize(file_or_text)
		@text = file_or_text.is_a?(File) ? read_file(file_or_text) : file_or_text
		return nil
	end

	def create_word_counts
		word_counts = Hash.new
		words = @text.split(/\s/)
		words.each do |word| 
			word.gsub!(noise_words_regexp, '')
			word = word.strip
			next if word.empty?
			word_counts[word] || word_counts[word] = 0
			word_counts[word] += 1

		end
		word_counts
	end

	def format_word_counts
		formatted_word_counts = ""
		word_counts = self.create_word_counts
		word_counts.each do |word_count|
			formatted_word_counts += word_count[1].to_s + 	
				" - " + word_count[0].to_s + "\n"
		end

		formatted_word_counts
	end

	def print_formatted_word_counts
		puts format_word_counts
	end

	private
	attr_reader :text

	def read_file(file_name)
		File.read(file_name)
	end

	def noise_words_regexp
		/[_\+{}:"\?\>\<\.,\n\-—\(\)\&@#\$%\^\*;!]+/
	end
end

