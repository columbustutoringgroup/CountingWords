require 'rspec'
require_relative '../lib/readfile.rb'

describe 'Number of words' do
    it 'get words return the proper number' do
      expect(getWords("one two three four").count).to eq 4
    end
end

describe 'Accounts for duplicates' do
    it 'same word only gets counted once' do
      expect(getWords("one two three one")["one"]).to eq 2
      expect(getWords("one two three one").count).to eq 3
    end
end

describe 'No Special Chars' do
    it 'No Special Chars' do
      expect(getWords("one two! one")["two"]).to eq 1
      expect(getWords("one two. one")["two"]).to eq 1
      expect(getWords("one two- one")["two"]).to eq 1
      expect(getWords("one two? one")["two"]).to eq 1
    end
end
