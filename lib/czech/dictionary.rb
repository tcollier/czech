class Czech::Dictionary
  VOWELS = "aeiou"

  attr_accessor :dict

  def initialize(words)
    @dict = {}
    words.each do |word|
      @dict[self.class.hash(word)] ||= []
      @dict[self.class.hash(word)] << word
    end
  end

  def suggest(word)
    if (suggestions = dict[self.class.hash word]).any?
      if suggestions.include?(word)
        word
      elsif index = suggestions.map(&:downcase).find_index(word.downcase)
        suggestions[index]
      else
        suggestions.first
      end
    else
      "NO SUGGESTION"
    end
  end
    
  def self.hash(word)
    previous_char = nil
    word.split.collect do |char|
      if VOWELS.split.include?(char)
        char = 'a'
      end
      unless previous_char == char
        previous_char = char
      end
    end.compact.join
  end
end