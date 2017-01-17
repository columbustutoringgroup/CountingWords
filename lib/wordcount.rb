def shred line #split lines into words
  line.split /[\?\.,_:;@#\n\$\^\*\<\>\%\&!{}\+\n\\"\)\(\-— ]+/
  #personalize regex for 'word' definition
end

def add_to_list array_of_words, list #adds only new words to hash list
  array_of_words.each do |word|
    key = word.upcase.capitalize #downcase to prevent case mattering
    if list.has_key? key #if word already exists, inc count
      list["#{key}"]=list["#{key}"]+1
    else #else create new hash key and value
      list["#{key}"] = 1
    end
  end
end

#reads file in and returns array for printing
def generate_list filename
  input = File.new filename, "r+" #opens file for reading
  list = Hash.new #creates hash for wordcount list
  shredded = Array.new #temporary storage for lines
  input.each_line do |line|
    shredded = shred line #break lines into words
    add_to_list shredded, list #adds words to hash of word, value pairs
  end
  array=list.to_a
  array.sort!{|a,b| b[1]<=>a[1]} #sort by count
end

def print_list filename
  list = generate_list filename
  puts "#{list.count} words in list"
  list.each do |pair| #prints
    puts "#{pair[1]} — #{pair[0]}"
  end
end

print_list "speech.txt"
