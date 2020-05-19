class CountWords

    # parse text
    def run(filename)

        # read the text file
        text = readFile(filename)

        # strip out non alpha characters
        cleanedText = stripCharacters(text.downcase)

        # count all words
        wordCount = countAllWords(cleanedText)

        # reverse sort word counts
        sortedWords = reverseSortWordCounts(wordCount)

        # display word plus it's found value
        displayWordCounts(sortedWords)
    end

    # get the contents of a file
    def readFile(filename)
        # TODO 1. ensure file extension is .txt
        #      2. limit file size or refactor app to stream lines
        #      3. ensure the file exists
        File.read(filename)
    end

    # strip non alpha characters from text
    def stripCharacters(text)
        text.scan(/[\w']+/)
    end

    # count all the words and add them to a hash
    def countAllWords(cleanedText)
        wordCount = {}
        cleanedText.each { |word|
            if wordCount[word] # if word exists, increment the number of times it has been found
                wordCount[word] = wordCount[word] + 1
            else               # if word does not exist, set it's found value to 1
                wordCount[word] = 1
            end
        }
        wordCount
    end

    # reverse sort word counts
    def reverseSortWordCounts(wordCount)
        wordCount.sort_by{|_key, value| value}.reverse
    end

    # display sorted word counts
    def displayWordCounts(sortedWords)
        sortedWords.each { |_key, value| 
            p _key + " is mentioned " + value.to_s + " times"
        }
    end
    
end

# CountWords.new.run('speech.txt')