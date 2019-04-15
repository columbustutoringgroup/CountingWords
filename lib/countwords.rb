class CountWords

  attr_accessor :word_count

  def count_words_from_file(file)
    count_file = File.open(file, "r")
    count_file.each_line do |line|
      next if line.empty?
      @@word_count = Hash.new
      word = line.split
      word.each do |wrd|
        next if wrd !~ /(\w+)/
        wrd = wrd[/(\w+)/]
        if @@word_count.has_key?(wrd)
          @@word_count[wrd] = @@word_count[wrd] + 1
        else
          @@word_count[wrd] = 1
        end
      end
      display_word_count_asc
    end

    count_file.close
    @@word_count
  end

  def display_word_count_asc
    puts ""
    puts "'''''"
    @@word_count.sort{|a,b| a[1]<=>b[1]}.each { |word|
      puts "#{word[1]} - #{word[0]}"
    }
    puts "'''''"
  end

end

def count_data
  data = CountWords.new
  data.count_words_from_file("speech.txt")
end

count_data
