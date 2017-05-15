require 'pp'

class WordCounter

  def run!
    # Read all the words into an array parsing out all of the special characters
    words = File.open("speech.txt", "r").read.split
    
    # Parse out all of the special characters
    words.each { |word| word.gsub!(/[_;+{}?><<@#$%^*.,!():&"-]/,'') }
    
    # Delete all of the empty strings that made
    words.delete_if { |word| word.length == 0 }
    
    # Count each instance and sort by descending order
    words_hash = Hash.new(0).tap { |word_count| words.each { |word| word_count[word] += 1 } }.sort_by {|k, v| v }.reverse
    
    # Print the result
    pp words_hash
  end

end

WordCounter.new.run!
