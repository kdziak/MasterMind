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
  attr_accessor :player_name, :guesser, :setter, :player_secret

  def initialize
    @player_name = player_name_getter
    guesser_or_setter
  end

  def player_name_getter
    p 'Hello challenger... what is your name?'
    gets.chomp
  end

  def guesser_or_setter
    p 'Do you want to (g)uess the code or (s)et the code?'
    answer = gets.chomp
    if answer == 's'
      @setter = true
    elsif answer == 'g'
      @guesser = true
    end
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

  def player_guess_setter
    puts 'Make your code human.'
    player_code = []
    while player_code.length < 4
      player_code << gets.chomp
    end
    @player_secret = player_code
  end
end

# class for gameplay and gamelogic
class Game
  attr_accessor :mastermind, :p1, :black_pegs, :white_pegs

  def initialize
    @black_pegs = 0
    @white_pegs = 0
    @turn_count = 0
    @board = []
    @game_over = false
    @mastermind = MasterMind.new
    @p1 = Player.new
    gameplay
    computer_code_breaker
  end

  def gameplay
    return unless p1.guesser == true

      until @game_over
        mastermind.computer_code
        player_array = p1.player_guess_getter
        code_to_guess = mastermind.computer_code
        win_checker(code_to_guess, player_array)
        use = color_checker_at_right_spot(code_to_guess, player_array)
        right_color_wrong_spot(use, player_array)
        @turn_count +=1
        turns = @turn_count
        turn_tracker(turns)
      end
  end

  def computer_code_breaker
    return unless p1.setter == true

    players_input = p1.player_guess_setter
      until @game_over
        all_combos = COLORS.repeated_permutation(4).to_a
        guess = all_combos.sample
        win_checker(players_input, guess)
        @turn_count += 1
        
      end
  end

  def win_checker(code_to_guess, player_array)
    return unless code_to_guess == player_array

    p 'You Won!'
    p player_array
    p @turn_count
    @game_over = true
    
  end

  def color_checker_at_right_spot(code_to_guess, player_array)
    black_peg = 0
    i = 0
    method_use = code_to_guess.clone
    method_use.each do |color|
      if color == player_array[i]
        black_peg += 1
        method_use[i] = nil
        player_array[i] = "!"
      end
      i += 1
    end
    p "You have #{black_peg} black pegs"
    @black_pegs = black_peg
    method_use
  end

  def right_color_wrong_spot(use, player_array)
    white_peg = 0
    player_array.each do |color|
      if color == use[0]
        white_peg += 1
        use[0] = nil
      elsif color == use[1]
        white_peg += 1
        use[1] = nil
      elsif color == use[2]
        white_peg += 1
        use[2] = nil
      elsif color == use[3]
        white_peg += 1
        use[3] = nil
      end
    end
    p "You have #{white_peg} white pegs"
    @white_pegs = white_peg
  end

  def turn_tracker(turns)
    if turns == 12
      @game_over = true
    end
  end
end

new_game = Game.new
