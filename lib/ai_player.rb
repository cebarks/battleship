require './lib/board'
require './lib/ship'
require './lib/battleship_game'

class AIPlayer
  attr_reader :ships, :board

  def initialize
    @ships = []
    @board = Board.new
  end

  def place_ships
    sizes = BattleshipGame::SHIP_SIZES
    coords = pick_coordinates
    sizes.each do |size|
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

  def print_board
    @board.print_board
  end

  def fire(coord)
    @board.hit(coord)
    @board.ship_hit?(coord)
  end

  def get_attack_coord
    @board.board_hash.keys.sample
  end

  def hit(coord)
    @board.hit(coord)
  end

  def hit?(coord)
    @board.hit?(coord)
  end

end
