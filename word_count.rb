#Generates the count of each word in the file sorted by the maximum occured word first
def wordCount
  file = File.open("speech.txt")

  words = file.read().downcase().split(/\W+/)
  words_map = {}
  words.map do |word|
    if words_map.has_key?(word)
      words_map[word] += 1
    else
      words_map[word] = 1
    end
  end
  #words_map.sort {|x,y| -(x[1]<=>y[1])} -- 16.7s
  #words_map.sort {|x,y| y[1] <=> x[1]} -- 12.3s
  #words_map.sort_by {|k,v| -v} -- 5.9s
  #words_map.sort_by {|k,v| v}.reverse -- 3.7
  puts words_map.sort_by {|k,v| v}.reverse.to_h
end

wordCount
