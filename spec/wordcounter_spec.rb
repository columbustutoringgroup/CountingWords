require 'rspec'
require_relative '../wordcounter'

describe '#countWords' do
  let(:counter) { Counter.new }

  context 'when string is unique' do
    it 'returns proper array' do
      expect(counter.countWords("maverick goose iceman")).to eq(
        [["maverick", 1],
         ["goose", 1],
         ["iceman", 1]])
    end
  end

  context 'when string is nonunique' do
    it 'returns proper array' do
      expect(counter.countWords("maverick maverick goose maverick iceman goose")).to eq(
        [["maverick", 3],
         ["goose", 2],
         ["iceman", 1]])
    end
  end

  context 'when string is nonunique, puntuated, with capitalization' do
    it 'returns proper array' do
      expect(counter.countWords("GOOSE! Maverick Goose goose, Iceman (icEman)")).to eq(
        [["goose", 3],
         ["iceman", 2],
         ["maverick", 1]])
    end
  end
end

describe '#printCount' do 
  let(:counter) { Counter.new }

  context 'when reading in file' do
    it 'does not raise an error' do 
      expect{counter.printCount("./speech.txt")}.not_to raise_error
    end
  end
end