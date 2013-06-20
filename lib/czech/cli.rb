class Czech::Cli
  attr_reader :dict

  def initialize
    puts "Loading the system dictionary..."
    words = File.read('/usr/share/dict/words').split
    @dict = Czech::Dictionary.new(words)
  end

  def run
    puts "Enter \\q to exit."
    while true
      print '>'
      $stdout.flush
      word = gets.chomp
      if word == '\q'
        puts "bye."
        return
      end
      puts @dict.suggest(word)
    end
  end
end