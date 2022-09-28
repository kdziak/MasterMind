# frozen_string_literal: true

COLORS = ['red', 'blue', 'green', 'purple', 'orange', 'cyan']
BOARD = []

# class for computer
class MasterMind
  attr_reader :computer_code

  def initialize
    @computer_code = secret_code_maker
  end

  def secret_code_maker
    numbers = 4.times.map { Random.rand(7) }
    colors = []
    numbers.each do |number|
      colors << COLORS[number - 1]
    end
    colors
  end
end

# class for human player
class Player
  attr_accessor :player_name

  def initialize
    @player_name = player_name_getter
  end

  def player_name_getter
    p 'Hello challenger... what is your name?'
    gets.chomp
  end

  def player_guess_getter
    puts "Make your silly guess mortal, known by the name #{@player_name}."
    guess_array = []
    while guess_array.length < 4
      guess_array << gets.chomp
    end
    BOARD << guess_array
    guess_array
  end
end

# class for gameplay and gamelogic
class Game
  attr_accessor :mastermind, :p1

  def initialize
    @turn_count = 0
    @board = []
    @game_over = false
    @mastermind = MasterMind.new
    @p1 = Player.new
    gameplay
  end

  def gameplay
    player_array = p1.player_guess_getter
    code_to_guess = mastermind.computer_code
    win_checker(code_to_guess, player_array)
    color_checker_at_right_spot(code_to_guess, player_array)
  end

  def win_checker(code_to_guess, player_array)
    return unless code_to_guess == player_array

    p 'You Won!'
  end

  def color_checker_at_right_spot(code_to_guess, player_array)
    i = 0
    code_to_guess.each do |color|
      if color == player_array[i]
        puts '1 Black Peg'
      elsif code_to_guess.include?(player_array[i])
        puts '1 white peg'
      else
        p 'got nothing for ya'
      end
      i += 1
    end
  end
end



new_game = Game.new
p new_game.mastermind.computer_code
p BOARD
