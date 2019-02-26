require_relative 'lib/count_words'

counter = Count_Words.new

File.open('speech.txt','r') do |file|
    file.each do |line|
        counter.count_words(line)
    end
    counter.order_book_by_count
    counter.render_book
end     
