
class Player
  attr_reader :board, :ships, :shots_taken
  def initialize
    @board = Board.new
    @ships = []
    @shots_taken = 0
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
        puts "#{ship.owner.class.to_s.gsub("Player",'')} #{ship.size}-ship was destroyed!"
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
    require 'pry'; binding.pry
    print "#{self.class.to_s.gsub("Player",' Board')}"
    @board.print_board(display_ships)
  end
end