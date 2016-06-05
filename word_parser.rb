module WordParser
  def self.read_file(file_path)
    File.open(file_path) { |f| f.read }
  end

  def self.to_arrayed_words(string)
    string.gsub!(/\s\-\s/, ' ')
    string.downcase.split(/\s/)
  end

  def self.clean_word(word)
    word.gsub!(/[^a-zA-Z\-']/, '')
    strip_single_quotes(word)
  end

  def self.clean_array(array)
    array.map { |word| clean_word(word) }
    remove_empty_strings(array)
  end

  def self.counted(array)
    word_hash = Hash.new(0)
    array.each do |word|
      word_hash[word] += 1
    end
    word_hash.sort_by { |word, count| count }.reverse
  end

  def self.output_to_console(counted_array)
    counted_array.each do |word|
      puts "#{ word[0] } - #{ word[1] }"
    end
  end

  def self.run(file)
    str = read_file(file)
    arr = to_arrayed_words(str)
    arr = clean_array(arr)
    counted_arr = counted(arr)
    output_to_console(counted_arr)
  end

  private

  def self.remove_empty_strings(array)
    array.reject { |word| word == '' }
  end

  def self.strip_single_quotes(word)
    word.gsub(/\A'|'\z/, '')
  end
end
