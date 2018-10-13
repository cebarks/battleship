require './lib/board'
require './lib/ship'

class AIPlayer
  attr_reader :ships, :board, :shots_taken

  def initialize
    @ships = []
    @board = Board.new
    @shots_taken = 0
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

  def check_ships
    @ships.each do |ship|
      if ship.destroyed
        puts "You destroyed the AI's #{ship.size}-ship!"
        @ships.delete(ship)
      end
    end
  end

  def pick_coordinates # returns an array of 2 coordinates
    coordinates = []
    2.times do
      coordinates << @board.board_hash.keys.sample
    end
    coordinates
  end

  def print_board(ships)
    print 'AI board'
    @board.print_board(ships)
  end

  def fire(coord)
    @shots_taken += 1
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
