require 'rspec'
require 'frequency_map'

describe FrequencyMap do

    it 'should be a Class' do
        expect(described_class.is_a? Class).to be true
    end

    it 'should return its set text' do
        set_text = "test"
        frequencyMap = FrequencyMap.new(set_text)
        expect(frequencyMap.text).to eq set_text
    end

    it 'should return a hash of type string->int when computing frequencies' do
        set_text = "dog dog cat mouse mouse mouse"
        frequencyMap = FrequencyMap.new(set_text)
        frequencies = frequencyMap.getFrequencies()

        expect(frequencies.is_a? Hash).to be true
        expect(frequencies.keys).to all( be_a(String))
        expect(frequencies.values).to all( be_a(Integer))
    end

    it 'should return correct frequencies for a normal case' do
        set_text = "dog dog cat mouse mouse mouse"
        frequencyMap = FrequencyMap.new(set_text)
        frequencies = frequencyMap.getFrequencies()

        expect(frequencies["dog"]).to eq 2
        expect(frequencies["cat"]).to eq 1
        expect(frequencies["mouse"]).to eq 3
        expect(frequencies["lion"]).to eq 0
    end

    it 'should return no frequencies for an empty case' do
        set_text = ""
        frequencyMap = FrequencyMap.new(set_text)
        frequencies = frequencyMap.getFrequencies()

        expect(frequencies.size).to eq 0
    end

    it 'should sort frequencies for a normal case' do
        set_text = "dog dog cat mouse mouse mouse"
        frequencyMap = FrequencyMap.new(set_text)
        frequencyMap.sortFrequencies

        expect(frequencyMap.sorted[0]).to eq ["mouse", 3]
        expect(frequencyMap.sorted[1]).to eq ["dog", 2]
        expect(frequencyMap.sorted[2]).to eq ["cat", 1]
    end

    it 'should return an empty array for an empty case' do
        set_text = ""
        frequencyMap = FrequencyMap.new(set_text)
        frequencyMap.sortFrequencies

        expect(frequencyMap.sorted).to be_empty
    end

    it 'should print sorted frequencies for a normal case' do
        set_text = "dog dog cat mouse mouse mouse"
        frequencyMap = FrequencyMap.new(set_text)
        expect(frequencyMap.printFrequencies()).to output("Hello!").to_stdout
    end

end
