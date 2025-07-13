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
    raise ArgumentError.new("Function guess called with nil argument") if (letter == nil) # null check ;)
    letter = letter.downcase # case insensitive
    # spec wants argument error if guess not in a-z
    raise ArgumentError.new(
      "Function guess expected argument letter in [a,..z], got #{letter}"
    ) unless letter.match?(/^[a-z]$/)
    # if its already guessed, return false
    return false if (@guesses.include? letter) || (@wrong_guesses.include? letter)
    if (@word.include? letter)
      @guesses << letter 
    else
      @wrong_guesses << letter 
    end
    true
  end
  #vp end guess method
#=end
  #vp begin check_win_or_lose
  def check_win_or_lose()
    @word.each_char do |ch|
      if !(@guesses.include? ch)
        return :play if @wrong_guesses.length < 7
        return :lose
      end #end if
    end #end @word char iteration
    return :win 
  end
  #vp end check_win_or_lose
  #vp begin words_with_guesses
  def word_with_guesses()
    out = ''
    @word.each_char do |ch|
      if !(@guesses.include? ch)
        out = out + '-'
      else
        out = out + ch
      end
    end
    out
  end
  #vp end words_With_guesses

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
