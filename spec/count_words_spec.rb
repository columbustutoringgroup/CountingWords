require 'rspec'
require 'count_words'

describe CountWords do
    it 'should be a Class' do
        expect(described_class.is_a? Class).to eq true
    end

    it 'should read a file that exists' do
        countWords = CountWords.new
        expect(countWords.readFile("speech.txt")).to be_a_kind_of(String)
    end
    
    it 'should strip out non alpha characters besides apostrophes' do
        # this could be expanded upon to include non keyboard characters
        countWords = CountWords.new
        text = "aaa./,;'[]\!@#$%^&*(){}|:<>?"
        expect(countWords.stripCharacters(text)).to eq ["aaa", "'"]
    end

    it 'should count words' do
        countWords = CountWords.new
        textArray = ["a", "wonderful", "world", "this", "is", "a", "super", "super", "super", "wonderful", "world"]
        textHash = { "a" => 2, "wonderful" => 2, "world" => 2, "this" => 1, "is" => 1, "super" => 3 }
        expect(countWords.countAllWords(textArray)).to eq textHash
    end

    it 'should reverse sort a hash' do
        countWords = CountWords.new
        textHash = { "a" => 1, "wonderful" => 2 }
        reverseSortedText = [["wonderful", 2], ["a", 1]]
        expect(countWords.reverseSortWordCounts(textHash)).to eq reverseSortedText
    end

    # TODO - figure out how to stub or mock console out and test the actual written output to console
end