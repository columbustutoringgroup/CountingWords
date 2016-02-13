class WordCounter
  def self.count file  
    raise 'WordCounter: no file given' unless file 
    # use inject to create a hash of word counts
    to_word_array(file).inject({}) { |h,w| h[w] ? h[w] += 1 : h[w] = 1; h }
  end

  private

  # get array of words 
  def self.to_word_array(file)
    IO.read(file)
      .gsub(/[^a-zA-Z']/,' ')
      .split(' ')
  end
end
