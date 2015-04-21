require 'word_counter'

describe WordCounter do
  describe '.count_words' do
    When(:result) { described_class.count_words(test_words) }

    context 'example from README file' do
      Given(:test_words) {
        "The cat is tall. The cat is much bigger than the mouse."
      }
      Then {
        result == {
          'the'    => 3,
          'cat'    => 2,
          'is'     => 2,
          'tall'   => 1,
          'mouse'  => 1,
          'bigger' => 1,
          'than'   => 1,
          'much'   => 1
        }
      }
    end # example from README file
  end # .count_words
end
