require 'rspec'
require_relative '../lib/count_words'

describe 'initializing book' do
    let(:test) { Count_Words.new }
  
    it 'test starts empty' do
      expect(test.book).to eq({})
    end
end  

describe 'counting a single string' do 
    let(:test){ Count_Words.new}

    it 'counters have correct values' do
        test.count_words('The cat is tall. The cat is much bigger than the mouse.')
        expected = {
            'the' => 3,
            'cat' => 2,
            'is' => 2,
            'tall' => 1,
            'mouse' => 1,
            'bigger' => 1,
            'than' => 1,
            'much' => 1
    }
        expect(test.book).to eq(expected)
    end
end

describe 'handle garbage' do 
end