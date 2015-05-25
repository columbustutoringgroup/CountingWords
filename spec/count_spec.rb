require 'count'

describe Count do
		let(:file) { File.new "speech.txt" }

		describe "existence of class" do
		it "exist" do
			expect(Count.new(file)).not_to be nil
		end
	end

	describe "Count #create_word_counts" do

		context "can read given file" do
			let(:counter) { Count.new(file) }

			it "does not throw exception" do
				
				expect { counter.create_word_counts }.not_to raise_exception
			end
			it "returns its content as an array" do

				expect(counter.create_word_counts.empty?).to be false
			end

			context "can create a hash with number of occurences as value and word as key" do
				it "finds 1 occurence of Mr" do
					expect(counter.create_word_counts['Mr']).to eql 1
				end
			end
		end

		context "can read given text" do
			let(:counter) { Count.new("This is Mr. and Mrs. Faulkner.\n\t    \t\t   \n\n \n    ") }
			it "does not throw exception" do
				
				expect { counter.create_word_counts }.not_to raise_exception
			end
			it "returns its content as an array" do

				expect(counter.create_word_counts.empty?).to be false
			end

			context "can create a hash with number of occurences as value and word as key" do
				it "finds 1 occurence of Mr" do
					expect(counter.create_word_counts['Mr']).to eql 1
				end
			end
		end
	end

	describe "Count #filter_noise_words initialized with text" do
		context "can filter noise words" do
			it "filters empty spaces out" do
				text_with_whitespace = "This is some text\n\t    \t\t   \n\n \n    "
				expect(Count.new(text_with_whitespace).create_word_counts[" "]).to be_nil
			end

			it "filters newlines out" do
				text_with_whitespace = "This is some text \n\t    \t\t   \n \n \n    "
				expect(Count.new(text_with_whitespace).create_word_counts["\n"]).to be_nil
			end
		end
	end

	describe "Count #filter_noise_words initialized with file" do
		let(:counter) { Count.new(file) }

		context "can filter noise words" do
			it "filters empty spaces out" do
				expect(counter.create_word_counts[" "]).to be_nil
			end


			it "filters newlines out" do
				expect(counter.create_word_counts["\n"]).to be_nil
			end

			it "filters special characters out" do
				expect(counter.create_word_counts['_+{}:"?><<..,']).to be_nil
			end
		end
	end

	describe "Count #format_word_counts" do
		let(:counter) { Count.new(file) }

		context "can format the word counts" do
			it "Mr is found only once" do
				formatted_word_counts = counter.format_word_counts
				expect(formatted_word_counts.scan('Mr').size).to eql 1 
			end

			it "to have one line for each word" do
				formatted_word_counts = counter.format_word_counts
				expect(formatted_word_counts.lines.size).to eql 343
			end
		end
	end
end
