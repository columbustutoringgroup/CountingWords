
class Parser
  def initialize(filename)
    @file = File.open(filename, "r")
    @text = ''
    @file.each_line do |txt|
      @text = @text + txt
    end
  end

  def array_of_words
    @text.split(/\W+/)
  end

  def map_words_to_count
    array = array_of_words
    obj = {}
    array.each do |item|
      item = item.downcase
      obj[item] = obj[item] + 1 if obj[item] != nil
      obj[item] = 1 if obj[item] == nil
    end
    obj
  end

  def decreasing_order_word_count
    map = map_words_to_count
    out_array = []
    map.each do |item|
      new_obj = {name: item[0], value: item[1]}
      out_array.push new_obj
    end
    out_array.sort_by {|item| item[:value]}.reverse
  end
end

speechParser = Parser.new './speech.txt'

map_of_words_and_counts = speechParser.decreasing_order_word_count

map_of_words_and_counts.each do |item|
  puts "#{item[:name]}, #{item[:value]}"
end
