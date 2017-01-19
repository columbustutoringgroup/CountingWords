count = 0
File.open("speech.txt").each do |line|
	line_arr = line.split(' ')
	count += line_arr.length
end
puts count