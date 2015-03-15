contents = File.open("speech.txt", "rb").read

def werd_counter(contents)
  #remove line breaks and period doesn't handle contractions well... assumes case well and we'll are same word.
  all_words = contents.gsub(/ *\n+/, ' ').gsub('\'', '').gsub('.', ' ').gsub(/[^a-zA-Z ]/,'').downcase.split

  # create hash to store results of frequency
  hash = Hash.new(0)

  all_words.each { |word| hash[word] += 1 }

  result = hash.sort_by{|k, v| v}.reverse.to_h
end

puts werd_counter(contents)

werd_counter(contents).each{|k,v| puts v.to_s + " - " + k }