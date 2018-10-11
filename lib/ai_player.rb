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
    valid_coords = false

    ship_sizes.each do |size|
      while !valid_coords
        if @board.add_ship(coords[0], coords[1], ship)


        if @board.is_placement_valid?(coords[0], coords[1], size)
          valid_coords = true
        else
          coords = pick_coordinates
        end
      end
      ship = Ship.new(self, size)
      @board.add_ship(coords[0], coords[1], ship)
      @ships << ship
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
