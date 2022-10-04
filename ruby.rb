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
    until @game_over
      mastermind.computer_code
      player_array = p1.player_guess_getter
      code_to_guess = mastermind.computer_code
      win_checker(code_to_guess, player_array)
      use = color_checker_at_right_spot(code_to_guess, player_array)
      right_color_wrong_spot(use, player_array)
      @board << player_array
      # p " These are you old guesses #{@board}"
      p @turn_count +=1
      turns = @turn_count
      turn_tracker(turns)
    end
  end

  def win_checker(code_to_guess, player_array)
    return unless code_to_guess == player_array

    p 'You Won!'
    @game_over = true
  end

  def color_checker_at_right_spot(code_to_guess, player_array)
    i = 0
    method_use = code_to_guess.clone
    method_use.each do |color|
      if color == player_array[i]
        p '1 black peg'
        method_use[i] = nil
        player_array[i] = "!"
      end
      i += 1
    end
  end

  def right_color_wrong_spot(use, player_array)
    player_array.each do |color|
      if color == use[0] 
        p 'white peg'
        use[0] = nil
      elsif color == use[1]
        p 'white peg'
        use[1] = nil
      elsif color == use[2]
        p 'white peg'
        use[2] = nil
      elsif color == use[3]
        p 'white peg'
        use[3] = nil
      end
    end
  end

  def turn_tracker(turns)
    if turns == 12
      @game_over = true
    end
  end
end

new_game = Game.new
p new_game.mastermind.computer_code
p BOARD
