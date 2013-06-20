require 'levenshtein'

class Czech::Dictionary
  attr_reader :dict

  def initialize(words)
    @dict = {}
    words.each { |word| add word }
  end

  def suggest(word)
    if suggestions = dict[Czech::Hasher.generate word]
      find_best word, suggestions
    else
      "NO SUGGESTION"
    end
  end

private

  def add(word)
    dict[Czech::Hasher.generate word] ||= []
    dict[Czech::Hasher.generate word] << word
  end

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