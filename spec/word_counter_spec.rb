require 'word_counter'

describe WordCounter do
  describe '.count_words' do
    When(:result) { described_class.count_words(test_words) }
    Invariant {
      result.values.each_cons(2).all? { |current_count, next_count|
        current_count >= next_count
      }
    }

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

    context 'words are sorted correctly when the first word does not occur most' do
      Given(:test_words) {
        "One fish. Two fish. Red fish. Blue fish."
      }
      Then {
        result == {
          'fish' => 4,
          'one'  => 1,
          'two'  => 1,
          'red'  => 1,
          'blue' => 1
        }
      }
    end # words are sorted correctly when the first word does not occur most

  end # .count_words
end
