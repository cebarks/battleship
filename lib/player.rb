
class Player
  attr_reader :board, :ships, :shots_taken, :guesses
  
  def initialize
    @board = Board.new
    @ships = []
    @shots_taken = 0
    @guesses = []
  end

  def place_ships
    sizes = BattleshipGame::SHIP_SIZES
    sizes.each do |size|
      coord_array = self.pick_coordinates(size)
      loop do
        if add_ship(coord_array[0], coord_array[1], size)
          break
        else
          coord_array = self.try_again(size)
        end
      end
    end
  end

  def try_again(size)
    pick_coordinates(size)
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
        puts "#{ship.owner.type} #{ship.size}-ship was destroyed!"
        @ships.delete(ship)
      end
    end
  end

  def hit(coord)
    @board.hit(coord)
  end

  def hit?(coord)
    @board.hit?(coord)
  end
  
  def fire(coord)
    @shots_taken += 1
    @board.hit(coord)
    @board.ship_hit?(coord)
  end

  def print_board(display_ships)
    print "#{self.type} Board"
    @board.print_board(display_ships)
  end

  def type
    self.class.to_s.gsub("Player",'')
  end
  
  def add_guess(coord, success)
    @guesses << [coord, success]
  end
  
  def last_guess_hit?
    @guesses.last.last
  end
  
  def last_guess
    @guesses.last.first
  end
  
  
end