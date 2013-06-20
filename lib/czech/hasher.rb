module Czech::Hasher
  VOWELS = %W[a e i o u].freeze

  def self.generate(word)
    previous_char = nil
    word.split('').collect do |char|
      char = VOWELS.include?(char.downcase) ? 'a' : char.downcase
      unless previous_char == char
        previous_char = char
      end
    end.compact.join
  end
end
