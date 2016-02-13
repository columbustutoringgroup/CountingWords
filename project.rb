require_relative 'word_counter'

p WordCounter.count(File.open('speech.txt','r'))
