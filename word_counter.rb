def word_counter(filepath)
  text = file_to_string(filepath)
  words_arr = text.split(' ')
  word_count = {}

  words_arr.each do |word|
    stripped_word = word.downcase.gsub(/[^a-z]/i, '')
    if word_count.key? word
      word_count[stripped_word] += 1
    else
      word_count[stripped_word] = 1 if stripped_word != ''
    end
  end

  print_hash(word_count)
end

def file_to_string(filepath)
  text = ''
  file_obj = File.new(filepath, 'r')

  while line = file_obj.gets
    text += line
  end
  file_obj.close

  text
end

def print_hash(hash)
  hash = hash.sort_by { |_k, v| v }.reverse

  hash.each do |key, value|
    puts "#{key} - #{value}"
  end
end

word_counter('speech.txt')
