class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(new_guess)
    
    if new_guess.nil? || new_guess.length == 0 || !(new_guess =~ /[A-Za-z]/) then
      raise ArgumentError
    end
    
    new_guess = new_guess.downcase
    
    if @word.include? new_guess then
      unless @guesses.include? new_guess then
        @guesses += new_guess
        return true
      end
      return false
    else
      unless @wrong_guesses.include? new_guess then
        @wrong_guesses += new_guess 
        return true
      end
      return false
    end
  end
  
  def word_with_guesses
    display = ""
    @word.each_char {|c| 
      if @guesses.include? c then
        display += c
      else
        display += "-"
      end
    }
    return display
  end
  
  def check_win_or_lose
    
    if @wrong_guesses.length > 6 then
      return :lose
    elsif word_with_guesses == @word then
      return :win
    else
      return :play
    end
    
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

@game = HangpersonGame.new('foobar')
@game.guess('a')
@game.guess('z')
@game.guess('x')
@game.guess('o')
puts @game.word_with_guesses
