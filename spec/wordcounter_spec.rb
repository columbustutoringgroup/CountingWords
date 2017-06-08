require 'rspec'
require 'tempfile'
require_relative '../lib/wordcounter'

PROJECT_ROOT = File.join(File.dirname(__FILE__), '..')

RSpec::Matchers.define :not_match do |regex|
  match do |actual|
    actual !~ regex
  end

  failure_message do |actual|
    "expected `#{actual}` to not match #{regex}"
  end
end

RSpec.shared_examples 'word counter' do |method, *args|
  context "##{method.to_s}" do
    subject(:counter) { WordCounter.new }

    it 'returns a histogram' do
      expect(counter.send(method, *args)).to be_a(WordHistogram)
    end

    it 'ignores punctuation' do
      histogram = counter.send(method, *args)
      expect(histogram.keys).to all(not_match /(\w?[.,\/#!?$%^&*;:{}=`+~()<>"])|(\w[-_])|([-_]\w)/)
    end

    it 'ignores case, forcing to lowercase' do
      histogram = counter.send(method, *args)
      keys = histogram.keys
      expect(keys).to match_array(keys.map &:downcase)
    end

    it 'is able to not ignore case' do
      histogram = counter.send(method, *args, ignorecase: false)
      keys = histogram.keys

      expect(keys).not_to match_array(keys.map &:downcase)
    end

    it 'only includes word characters' do
      histogram = counter.send(method, *args)
      expect(histogram.keys).to all(match /^[\w'\-_]+$/)
    end
  end
end

describe 'WordHistogram' do
  let(:hist) { WordHistogram.new }

  it 'defaults to a word frequency of 0' do
    expect(hist['a']).to eq 0
  end

  before { hist[:a] += 1 }
  it 'allows frequency updates by behaving like a Hash' do
    expect(hist[:a]).to eq 1
  end

  it 'is sortable' do
    expect { hist.send(:sort_histogram) }.not_to raise_error
  end

  it 'sorts into an array' do
    expect(hist.send(:sort_histogram)).to be_a(Array)
  end

  context 'while containing data' do
    subject do
      hist = WordHistogram.new
      hist['hello'] = 6
      hist['jello'] = 3
      hist['jelly'] = 3
      hist['jella'] = 5
      hist['jellq'] = 3
      hist
    end

    it '#sort returns a properly sorted array when sorted' do
      expect(subject.send :sort_histogram).to match_array [['hello', 6], ['jella', 5], ['jello', 3], ['jellq', 3], ['jelly', 3] ]
    end

    it '#to_pretty_s can create a pretty string from the histogram' do
      expect(subject.to_pretty_s).to be_a(String)
    end

    it '#to_pretty_s is able to provide a prettily formatted table' do
      result = subject.to_pretty_s
      to_result_line = lambda { |rank, word| '%-3d: %-2s %-3d' % [rank, word, subject[word]] }

      lines = [
          to_result_line.call(1, 'hello'),
          to_result_line.call(2, 'jella'),
          to_result_line.call(3, 'jello'),
          to_result_line.call(3, 'jellq'),
          to_result_line.call(3, 'jelly'),
      ]

      expect(result).to eq(lines.join "\n")
    end
  end
end

describe 'WordCounter' do

  context 'cleaning: hypens-and_underscores-and_conjunction\'s' do
    subject(:counter) { WordCounter.new }
    subject { 'hypens-and_underscores-and_conjunction\'s' }

    cleaners = {
        drop_word_joiners: /(?![-_])*/,
        drop_conjunctions: /(?!\w'\w)*/,
        drop_nonwords: /[^\W]*/,
        cleanse: /[\w\s]*/,
    }

    cleaners.each do |method, regex|
      it "##{method}" do
        result = counter.send(method, subject)
        expect(result).to match regex
      end
    end
  end

  context 'when counting words in sentences' do
      include_examples 'word counter', :count, 'This is a sentence wit\'h some text and punctuation!'
  end

  context 'when counting words from a file' do
    subject { WordCounter.new }

    it 'accepts valid file paths' do
      expect { subject.count_file __FILE__ }.not_to raise_error
    end

    it 'raises an error for invalid file paths' do
      expect { subject.count_file 'NOT_A_VALID_PATH___@@@::?;' }.to raise_error Errno::ENOENT
    end

    it 'raises an error for closed file objects' do
      (file = Tempfile.open).close
      expect { subject.count_file file }.to raise_error IOError
    end

    it 'accepts file objects' do
      expect { Tempfile.open { |file| subject.count_file file } }.not_to raise_error
    end

    it 'returns a histogram' do
      expect(subject.count_file __FILE__).to be_a(WordHistogram)
    end

    context 'which contains a simple text' do
      include_examples 'word counter', :count_file, 'simple_test.txt'
    end

    context 'which contains a presidential speech' do
      include_examples 'word counter', :count_file, 'speech.txt'
    end
  end

end