require 'thor'
require 'word_counter'

class WordTasks < Thor

  desc 'count_words_and_occurrences', 'Counts the words and occurences in a string or file, ordered by the number of occurences for each word.'
  method_option :words,
    aliases: ['-w'],
    type: :string,
    desc: 'A string of words'
  method_option :file_name,
    aliases: ['-f'],
    type: :string,
    desc: 'Count the occurences of words in the file'
  def count_words_and_occurrences
    words = options[:words]
    words = File.read(options[:file_name]) if options[:file_name]
    WordCounter.count_words(words).each_pair do |word, count|
      puts "#{word}: #{count}"
    end
  end

end
