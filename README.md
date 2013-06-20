# Czech

A spell checker that solves the following coding challenge:

Write a program that reads a large list of English words (e.g. from /usr/share/dict/words on a unix system) into memory, and then reads words from stdin, and prints either the best spelling suggestion, or "NO SUGGESTION" if no suggestion can be found. The program should print ">" as a prompt before reading each word, and should loop until killed.

Your solution should be faster than O(n) per word checked, where n is the length of the dictionary. That is to say, you can't scan the dictionary every time you want to spellcheck a word.

For example:

    > sheeeeep
    sheep
    > peepple
    people
    > sheeple
    NO SUGGESTION

The class of spelling mistakes to be corrected is as follows:

* Case (upper/lower) errors: "inSIDE" => "inside"
* Repeated letters: "jjoobbb" => "job"
* Incorrect vowels: "weke" => "wake"

Any combination of the above types of error in a single word should be corrected (e.g. "CUNsperrICY" => "conspiracy").

If there are many possible corrections of an input word, your program can choose one in any way you like. It just has to be an English word that is a spelling correction of the input by the above rules.

## Installation

Add this line to your application's Gemfile:

    gem 'czech'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install czech

## Usage

The gem installs a command line tool that can be invoked by running 'czech'

Alternatively, you can programmatically use the Czech::Dictionary class as follows:

    czech = Czech::Dictionary.new(array_of_words)
    suggestion = czech.suggest(word_that_may_be_incorrect)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
