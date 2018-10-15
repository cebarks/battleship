require './lib/board'
require './lib/ship'
require './lib/player'

class AIPlayer < Player
  
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

end
