
class Parser
  def initialize(filename)
    file = File.open(filename, "r")
    @text = ''
    file.each_line do |txt|
      @text += txt
    end
  end

  def array_of_words
    @text.split(/\W+/)
  end

  def map_words_to_count
    array = array_of_words
    hash = {}
    array.each do |item|
      item = item.downcase
      if hash[item] == nil
        hash[item] = 1
      else
        hash[item] += 1
      end
    end
    hash
  end

  def decreasing_order_word_count
    map_arr = map_words_to_count.to_a
    map_arr = map_arr.sort_by {|tuple| tuple[1]}.reverse
  end
end

speechParser = Parser.new './speech.txt'

map_of_words_and_counts = speechParser.decreasing_order_word_count

map_of_words_and_counts.each do |item|
  puts "#{item[0]} => #{item[1]}"
end
