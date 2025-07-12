class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses =''
    @wrong_guesses = ''
  end
  #vp beginning guess method, may have to move until the end of get_random_word?
#=begin
  def guess(letter)
    if (@word.include? letter)
      @guesses << letter if !(@guesses.include? letter)
    else
      @wrong_guesses << letter if !(@wrong_guesses.include? letter)
    end
  end
  #vp end guess method
#=end
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end #end Net:: ... block
  end # end get_random_word method
end # class end
