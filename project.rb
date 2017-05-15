require_relative 'word_counter'

# you can initialize and use a new WordCounter with a file
counter = WordCounter.new(File.open('speech.txt','r'))
p counter.ordered_word_count

# but you can call word_count on any file so that you
# don't have to create a new WordCount object every time you
# create a new file; you can just use the existing one
p counter.ordered_word_count(File.open('speech.txt','r'))
