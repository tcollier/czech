require 'levenshtein'

class Czech::Dictionary
  VOWELS = %W[a e i o u].freeze

  attr_accessor :dict

  def initialize(words)
    @dict = {}
    words.each do |word|
      @dict[self.class.hash(word)] ||= []
      @dict[self.class.hash(word)] << word
    end
  end
    
  def self.hash(word)
    previous_char = nil
    word.split('').collect do |char|
      char = VOWELS.include?(char.downcase) ? 'a' : char.downcase
      unless previous_char == char
        previous_char = char
      end
    end.compact.join
  end

  def suggest(word)
    if suggestions = dict[self.class.hash word]
      find_best word, suggestions
    else
      "NO SUGGESTION"
    end
  end

private
  def find_best(word, suggestions)
    if suggestions.include?(word)
      word
    elsif index = suggestions.map(&:downcase).find_index(word.downcase)
      suggestions[index]
    else
      nearest word, suggestions
    end
  end

  def nearest(word, suggestions)
    dists = suggestions.collect { |w| Levenshtein.distance(word.downcase, w.downcase) }
    index_of_min_dist = dists.index(dists.min)
    suggestions[index_of_min_dist]
  end
end