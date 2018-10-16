require './lib/board'
require './lib/ship'
require './lib/player'

class AIPlayer < Player
  
  def print_board
    puts "Your hits and misses"
    super(false)
  end
  
  def pick_coordinates(size) # returns an array of 2 coordinates
    coordinates = []
    2.times do
      coordinates << @board.board_hash.keys.sample
    end
    coordinates
  end

  def get_attack_coord
    if @shots_taken == 0
      return "B2"
    elsif last_guess_hit?
      return adjacent_coord(last_guess)
    else
      return @board.board_hash.keys.sample
    end
  end
  
  def lose
    puts 'Congratulations, you won!'
  end
  
  def print_hit(success, coord)
    puts 'AI is thinking...'
    sleep(1)
    if success
      puts "So sad. Your ship at #{coord} was hit!"
    else
      puts "Yay! Your enemy missed their shot fired at #{coord}"
    end

    puts 'The current state of your board.'
  end
  
  def adjacent_coord(coord)
    letter = coord[0]
    number = coord[1].to_i
    
    loop do
      if rand(2) == 0
        #iterate on the letter
        if rand(2) == 0
          new_letter = letter.next
        else
          new_letter = (letter.ord - 1).chr
        end
        if @board.is_coord_valid?(new_letter + number.to_s)
          return new_letter + number.to_s
        end
      else
        #iterate on the number
        if rand(2) == 0
          new_number = number + 1
        else
          new_number = number - 1
        end
        if @board.is_coord_valid?(letter + new_number.to_s)
          return letter + new_number.to_s
        end
      end
    end
  end
end
