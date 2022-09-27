COLORS = ['red', 'blue', 'green', 'purple', 'orange', 'cyan']

  def secret_code
    numbers = 4.times.map { Random.rand(7) }
    colors = []
    numbers.each do |number|
      colors << COLORS[number - 1]
    end
    colors
  end

  def player_guess
    guess_array = []
    while guess_array.length < 4
      guess_array << gets.chomp
    end
    guess_array
  end


p secret_code
p player_guess