class Czech::Cli
  attr_reader :dict

  def initialize(file_name)
    puts "Loading the system dictionary, this may take a several seconds..."
    words = File.read(file_name).split
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