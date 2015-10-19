require 'rspec'
require_relative 'count'

describe 'WordCount' do
  let(:words) { WordCount.new }

  it "returns text when file is loaded" do
    expect(words.load_file('speech.txt')).not_to be_nil
  end

  it "speech contains no special characters after parsing" do
    words.load_file('speech.txt')
    words.parse_words
    expect(words.speech =~ /^0-9a-zA-z\s/i).to be nil
  end

  it "counts words correctly" do
    words.speech = "One two three one two four"
    words.parse_words
    words.count_words
    expect(words.counted_words["one"]).to eq 2
    expect(words.counted_words["two"]).to eq 2
    expect(words.counted_words["three"]).to eq 1
    expect(words.counted_words["four"]).to eq 1
  end
end
