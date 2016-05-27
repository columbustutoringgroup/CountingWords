file = File.open("./speech.txt",'rb')
WORD_REGEX = /[a-zA-Z]+['-]?[a-zA-Z]+/
words = file.read.scan(WORD_REGEX).map(&:downcase).group_by{|val|val}.sort_by{|k,v|-v.count}
words.each{|pair|
	puts "#{pair[0]}: #{pair[1].count}"
}

