class FrequencyMap

    attr_reader :text
    attr_reader :sorted

    def initialize(text)
        @text = text
        @frequencies = Hash.new(0)
    end

    def getFrequencies()
        @frequencies = Hash.new(0)
        words = @text.split(" ")

        words.each do |word|

            # Remove special chars and convert to lowercase
            word = word.downcase.gsub(/[^0-9a-z ]/i, '')

            if @frequencies.keys.include? word
                @frequencies[word] += 1
            else
                @frequencies[word] = 1
            end

        end

        @frequencies
    end

    def sortFrequencies
        self.getFrequencies

        @sorted = @frequencies.sort_by { |key, value| value}.reverse
    end

    def printFrequencies
        self.getFrequencies
        self.sortFrequencies

        @sorted.each do |pair|
            word =  pair[0]
            freq = pair[1]

            p "#{freq} - #{word}"

        end


    end
end
