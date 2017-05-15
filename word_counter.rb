require 'pry'

class WordCounter
  attr_accessor :file, :file_string, :word_array

  # you can choose to initialize a new WordCounter 
  # with or without a file
  def initialize(file = nil)
    setup_new_file(file) unless file.nil?
  end
  
  # you can choose to pass any file into WordCounter
  # and the internal state of your WordCounter 
  # instance will be setup to reflect your new file
  def ordered_word_count(file = nil)
    initialize(file) unless file.nil?

    # will create a hash of counts and then transform that hash into an
    # array of arrays ordered by highest count to lowest count
    @word_array.each_with_object(Hash.new(0)) { |word,hash| hash[word] += 1 }
               .sort_by { |key,val| val }
               .reverse
  end
  
  private

  # get file contents as string
  def read_file
    @file_string = IO.read(@file)
  end

  # remove non-words and set word_array 
  def parse_file
    @file_string.gsub!(/[^a-zA-Z']/,' ')
  end

  def set_word_array
    @word_array = @file_string.split(' ')
  end

  def setup_new_file(file)
    @file = file
    read_file
    parse_file
    set_word_array
  end
end
