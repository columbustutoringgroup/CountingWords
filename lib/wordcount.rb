#split lines into array of words
def line_split line
  line.split /[\?\.,_:;@#\n\$\^\*\<\>\%\&!{}\+\n\\"\)\(\-— ]+/
  #personalize regex for 'word' definition
end

#sort words by count
def sort_list list
  list.to_a.sort!{|a,b| b[1]<=>a[1]}
end

#generate ordered array of word count
def generate_list filename
  list=Hash.new
  File.open(filename, "r+").each_line do |line|
    (line_split line).each do |word|
      if list.has_key? word.capitalize
        list[word.capitalize] += 1
      else
        list[word.capitalize] = 1
      end
    end
  end
  sort_list list
end

#print list out with 'Frequency# - Word' format
def print_list filename
  list = generate_list filename
  puts "#{list.count} words in list"
  list.each do |pair| #prints
    puts "#{pair[1]} — "+pair[0]
  end
end

print_list "speech.txt"
