require './lib/ship'

class HumanPlayer
  def initialize
    @board = Board.new
    @ships = []
  end

  def turn; end

  def add_ship(coord_1, coord_2, ship)
    @ships << ship
    @board.add_ship(coord_1, coord_2, ship)
  end

  def fire(coord); end

  def place_ships
    # add_ship_2_proc = Proc.new do
    #   loc = prompt_ship_location(2)
    #   add_ship(loc[0], loc[1], Ship.new(self, 2))
    # end
    #
    # add_ship_3_proc = Proc.new do
    #   loc = prompt_ship_location(3)
    #   add_ship(loc[0], loc[1], Ship.new(self, 3))
    # end

    add_ship_2_proc = make_add_ship_proc(2)

    add_ship_3_proc = make_add_ship_proc(3)
    require 'pry'; binding.pry

    # There should be a way to programatically create this for any number of sizes for ships
    repl_procs = {
      %w[2] => add_ship_2_proc,
      %w[3] => add_ship_3_proc,
      %w[quit done q d] => Proc.new {@repl.stop}
    }

    message =
%{Where would you like your ships to be commander?
Please select a ship to start.}

    @repl = Repl.new('> ', message, repl_procs)

    @repl.run
  end

  def make_add_ship_proc(size)
    return Proc.new do
      loc = prompt_ship_location(size)
      add_ship(loc[0], loc[1], Ship.new(self, size))
    end
  end

  def prompt_ship_location(size)
    puts "Where would you like your #{size} ship? Please enter it in the following format: coord1-coord2"
    print '> '
    input = get_input

    input.split('-')
  end

  def get_input
    input = $stdin.gets
    if input.nil?
      return ""
    end
    input.chomp.downcase
  end
end
