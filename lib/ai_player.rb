require './lib/board'
require './lib/ship'

class AIPlayer
  attr_reader :ships, :board

  def initialize
    @ships = []
    @board = Board.new
  end

  def place_ships
    ship_sizes = [2, 3] # array representing the ships and their sizes
    coords = pick_coordinates
    ship_sizes.each do |size|
      loop do
        if add_ship(coords[0], coords[1], size)
          break
        else
          coords = pick_coordinates
        end
      end
    end
  end

  def add_ship(coord_1, coord_2, size)
    ship = Ship.new(self, size)
    if @board.add_ship(coord_1, coord_2, ship)
      @ships << ship
      true
    else
      false
    end
  end


  def pick_coordinates # returns an array of 2 coordinates
    coordinates = []
    2.times do
      coordinates << @board.board_hash.keys.sample
    end
    coordinates
  end
end
