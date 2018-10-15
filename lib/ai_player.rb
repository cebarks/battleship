require './lib/board'
require './lib/ship'
require './lib/player'

class AIPlayer < Player

  def place_ships
    sizes = BattleshipGame::SHIP_SIZES
    coords = pick_coordinates(sizes[0])
    sizes.each do |size|
      loop do
        if add_ship(coords[0], coords[1], size)
          break
        else
          coords = pick_coordinates(size)
        end
      end
    end
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


end
