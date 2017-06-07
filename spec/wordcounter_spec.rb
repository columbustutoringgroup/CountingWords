require 'rspec'
require_relative '../lib/wordcounter'

PROJECT_ROOT = File.join(File.dirname(__FILE__), '..')

def read_file(path)
  puts File.absolute_path path
  
  File.open(path, 'r') do |f|
    f.readlines.join "\n"
  end
end

RSpec::Matchers.define :not_match do |regex|
  match do |actual|
    actual !~ regex
  end

  failure_message do |actual|
    "expected #{actual} to not match #{regex}"
  end
end

describe 'WordHistogram' do
  let(:hist) { WordHistogram.new }

  subject(:long_hist) do
    hist = WordHistogram.new
    hist['hello'] = 6
    hist['jello'] = 3
    hist['jelly'] = 3
    hist['jella'] = 5
    hist['jellq'] = 3

    hist
  end

  subject(:short_hist) do
    histogram = WordHistogram.new
    histogram['a'] = 2
    histogram['be'] = histogram['ba'] = 1
    histogram
  end

  it 'defaults to a word frequency of 0' do
    expect(hist['a']).to eq 0
  end

  it 'allows frequency updates by behaving like a Hash' do
    hist[:a] += 1
    hist[:b] += 4
    hist[:z] += rand(1..100)

    expect(hist).to include( { a: 1, b: 4 } )
    expect(hist[:z]).not_to be_zero
  end

  it 'is sortable' do
    expect { hist.send(:sort) }.not_to raise_error
  end

  it 'sorts into an array' do
    expect(hist.send(:sort)).to be_a(Array)
  end

  it 'returns a properly sorted array when sorted' do
    result = long_hist.send(:sort)
    expect(result).to match_array [ ['hello', 6], ['jella', 5], ['jello', 3], ['jellq', 3], ['jelly', 3] ]
  end

  it 'creates a pretty string from itself' do
    expect(short_hist.to_pretty_s).to be_a(String)
  end

  it 'is able to provide a prettily formatted table' do
    result = short_hist.to_pretty_s
    to_result_line = lambda { |rank, word, freq| '%-3d: %-2s %-3d' % [rank, word, freq] }

    lines = [
        to_result_line.call(1, 'a', 2),
        to_result_line.call(2, 'ba', 1),
        to_result_line.call(2, 'be', 1),
    ]

    expect(result).to eq(lines.join "\n")
  end

end

describe 'WordCounter' do
  let(:counter) { WordCounter.new }
  subject(:sentence) { 'This is a sentence wit\'h some text and puntuation!' }
  subject(:speech_path) { 'speech.txt' }
  subject(:simple_test_path) { 'simple_test.txt' }

  it 'removes all hyphens' do
    result = counter.send(:drop_word_joiners, '-hyphens-in-my-sentence and stuff.')
    expect(result).not_to include('-')
  end

  it 'removes all underscores' do
    result = counter.send(:drop_word_joiners, '_secret_variable_in_python')
    expect(result).not_to include('_')
  end

  it 'removes all conjunctions' do
    result = counter.send(:drop_conjunctions, "didn't do nothin'")
    expect(result).to eq "didnt do nothin'"
  end

  it 'removes nonword characters' do
    result = counter.send(:drop_nonwords, '_+{}:"?><<..,It is therefore')

    # We don't care about whitespace, only non-whitespace characters left.
    # This is because the Counter is allowed to replace non-word characters with spaces.
    # But spaces are non-word characters as per the group for \W
    result.gsub!(/\s/, '')

    expect(result).to not_match /.*\W.*/
  end

  context 'when counting words in sentences' do
    it 'returns a histogram' do
      expect(counter.count sentence).to be_a(WordHistogram)
    end

    it 'ignores punctuation' do
      histogram = counter.count sentence
      expect(histogram.keys).to all(not_match /(\w?[.,\/#!?$%^&*;:{}=`+~()<>"])|(\w[-_])|([-_]\w)/)
    end

    it 'ignores case, forcing to lowercase' do
      histogram = counter.count sentence
      keys = histogram.keys
      expect(keys).to match_array(keys.map &:downcase)
    end

    it 'is able to not ignore case' do
      histogram = counter.count sentence, ignorecase: false
      keys = histogram.keys

      expect(keys).not_to match_array(keys.map &:downcase)
    end

    it 'only includes word characters' do
      histogram = counter.count sentence
      expect(histogram.keys).to all(match /^[\w'\-_]+$/)
    end
  end

  context 'when counting words from a file' do

    it 'accepts valid file paths' do
      expect { counter.count_file speech_path }.not_to raise_error
    end

    it 'raises an error for invalid file paths' do
      expect { counter.count_file 'NOT_A_VALID_PATH___@@@' }.to raise_error Errno::ENOENT
    end

    it 'raises an error for closed file objects' do
      expect do
        file = File.open speech_path
        file.close

        counter.count_file file
      end.to raise_error IOError
    end

    it 'accepts file objects' do
      expect { File.open(speech_path) { |file| counter.count_file file } }.not_to raise_error
    end

    it 'returns a histogram' do
      expect(counter.count_file speech_path).to be_a(WordHistogram)
    end

    context 'which contains a simple text' do

      it 'ignores punctuation' do
        simple_histogram = counter.count_file simple_test_path

        expect(simple_histogram.keys).to all(not_match /(\w?[.,\/#!?$%^&*;:{}=`+~()<>"])|(\w[-_])|([-_]\w)/)
      end

      it 'ignores case, forcing to lowercase' do
        simple_histogram = counter.count_file simple_test_path
        words = simple_histogram.keys
        expect(words).to match_array words.map(&:downcase)
      end

      it 'is able to not ignore case' do
        histogram = counter.count_file simple_test_path, ignorecase: false
        keys = histogram.keys

        expect(keys).not_to match_array(keys.map &:downcase)
      end

      it 'only includes word characters' do
        simple_histogram = counter.count_file simple_test_path

        expect(simple_histogram.keys).to all(match /^[\w'\-_]+$/)
      end
    end

    context 'which contains a presidential speech' do
      it 'ignores punctuation' do
        speech_histogram = counter.count_file speech_path

        expect(speech_histogram.keys).to all(not_match /(\w?[.,\/#!?$%^&*;:{}=`+~()<>"])|(\w[-_])|([-_]\w)/)
      end

      it 'ignores case, forcing to lowercase' do
        speech_histogram = counter.count_file speech_path
        words = speech_histogram.keys
        expect(words).to match_array words.map(&:downcase)
      end

      it 'is able to not ignore case' do
        histogram = counter.count_file speech_path, ignorecase: false
        keys = histogram.keys

        expect(keys).not_to match_array(keys.map &:downcase)
      end

      it 'only includes word characters' do
        speech_histogram = counter.count_file speech_path

        expect(speech_histogram.keys).to all(match /^[\w'\-_]+$/)
      end
    end
  end

end