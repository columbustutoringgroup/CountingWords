require_relative 'word_counter'

describe WordCounter do
  let(:app) { WordCounter.new }

  describe '#initialize' do
    it 'creates an instance of WordCounter' do
      expect(described_class).to eq(WordCounter)
    end
  end
end
