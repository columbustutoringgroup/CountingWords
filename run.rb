require_relative 'lib/frequency_map'

text = File.open("speech.txt").read
frequencyMap = FrequencyMap.new(text)
frequencyMap.printFrequencies
