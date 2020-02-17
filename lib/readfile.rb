
def readFile(file)
  return File.read(file)
end


def getWords(text)
  text.gsub!(/[^A-Za-z ]/,'')
  data = Hash.new
  temparray = text.to_s.split(" ").map(&:to_s)
  for word in temparray
      if(data.has_key?(word))
        data[word] += 1
      else
        data[word] = 1
      end
  end
  return data
end

def printWords(data)
  data = data.sort_by { |key, value| value }.reverse
  data.each do |key, value|
    puts key.to_s + ' ' + value.to_s
  end
end


text = readFile("/Users/apetit/CountingWords/speech.txt")
data = getWords(text)
printWords(data)
