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
      @board.board_hash.keys.sample
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
end
