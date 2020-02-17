require_relative '../word_parser.rb'

describe 'Word parser' do
  
  let(:parser) { WordParser }
  let(:file_path) { 'spec/data/words.txt' }
  let(:word_string) { "The cat is tall. The _+{}:\"\n?><<..,cat is much - bigger than the mouse." }
  let(:word_array) { ["the", "cat", "is", "tall.", "the", "_+{}:\"", "?><<..,cat", "is", "much", "bigger", "than", "the", "mouse."] }
  let(:cleaned_array) { ["the", "cat", "is", "tall", "the", "cat", "is", "much", "bigger", "than", "the", "mouse"] }
  let(:counted_array) { [["the", 3], ["cat", 2], ["is", 2], ["much", 1], ["tall", 1], ["bigger", 1], ["than", 1], ["mouse", 1]] }

  it 'reads in the file' do
    words = parser.read_file(file_path)
    expect(words).to eq word_string
  end

  it 'creates an array of words' do
    array = parser.to_arrayed_words(word_string)
    expect(array).to eq word_array
  end

  it 'cleans a normal word' do
    expect(parser.clean_word("test")).to eq "test"
  end

  it 'cleans a garbage word' do
    expect(parser.clean_word("_+{}:\"?><<..,")).to eq ''
  end

  it 'cleans a hyphenated word' do
    expect(parser.clean_word("bug-eyed")).to eq "bug-eyed"
  end

  it 'cleans a contracted word' do
    expect(parser.clean_word("'can't'")).to eq "can't"
  end

  it 'cleans a word array' do
    expect(parser.clean_array(word_array)).to eq cleaned_array
  end

  it 'counts the words' do
    expect(parser.counted(cleaned_array)).to eq counted_array
  end
end
