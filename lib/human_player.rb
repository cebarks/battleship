require './lib/ship'
require './lib/board'
require './lib/repl'

class HumanPlayer
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

  def hit(coord)
    @board.hit(coord)
  end

  def hit?(coord)
    @board.hit?(coord)
  end

  def place_ships
    sizes = BattleshipGame::SHIP_SIZES

    puts %{I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and D4 at the bottom right.}

    sizes.each do |size|
      loop do
        coord_array = prompt_ship_location(size)
        if add_ship(coord_array[0], coord_array[1], size)
          break
        else
          puts "Try that again. ;)"
        end
      end
    end
  end

  def prompt_ship_location(size)
    #loop do
      puts "Enter the squares for the #{size}-unit ship. Please enter it in the following format: coord1 coord2"
      print '> '
      input = get_input

      coords = input.split(' ')
      # break_boolean = false
      # coords.each do |coord|
      #   if (/([A-Z][1-9])/.match?(coord))
      #     break_boolean = true
      #   end
      # end
      # break if break_boolean
    #end
  end

  def check_ships
    @ships.each do |ship|
      if ship.destroyed
        puts "Your #{ship.size}-ship was destroyed!"
        @ships.delete(ship)
      end
    end
  end

  def get_attack_coord
    puts "Enter your attack coord:"
    print '> '
    get_input
  end

  def fire(coord)
    @shots_taken += 1
    @board.hit(coord)
    @board.ship_hit?(coord)
  end

  def get_input
    input = $stdin.gets
    if input.nil?
      return ""
    end
    input.chomp.upcase
  end

  def print_board(ships)
    print 'Your Board'
    @board.print_board(ships)
  end
end
