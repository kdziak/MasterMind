COLORS = ['red', 'blue', 'green', 'purple', 'orange', 'cyan']

def secret_code_maker
  numbers = 4.times.map { Random.rand(7) }
  colors = []
  numbers.each do |number|
    colors << COLORS[number - 1]
  end
  colors
end

def player_guess_getter
  guess_array = []
  while guess_array.length < 4
    guess_array << gets.chomp
  end
  guess_array
end

def win_checker(computer_code, player_array)
  return unless computer_code == player_array

  p 'You Won!'
end
computer_code = secret_code_maker
p computer_code
player_array = player_guess_getter

def color_checker_at_right_spot(computer_code, player_array)
  i = 0
  computer_code.each do |color|
    if color == player_array[i]
      puts '1 Black Peg' #this should increment a variable
    elsif computer_code.include?(player_array[i])
      puts '1 white peg'
    else
      p 'got nothing for ya'
    end
    i += 1
  end
end

win_checker(computer_code, player_array)
color_checker_at_right_spot(computer_code, player_array)

p player_array
