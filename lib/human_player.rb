require './lib/ship'
require './lib/board'
require './lib/repl'
require './lib/player'

class HumanPlayer < Player
  
  def place_ships
    puts %{I have laid out my ships on the grid.
You now need to layout your ships.
The grid has A1 at the top left. The board looks like this:}
@board.print_board(false)
  super
  end

  def print_board
    super(true)
  end
  
  def pick_coordinates(size)
    loop do
      puts "Enter the squares for the #{size}-unit ship. Please enter it in the following format: coord1 coord2"
      print '> '
      input = get_input
      coords = input.split(' ')
      
      coords = coords.select do |coord|
        /([A-Z][1-9])/.match?(coord)
      end
      if coords.size == 2
        return coords
      else
        puts "Enter the coordinates as a letter followed by a number, e.g. A1 A2"
      end
    end
  end

  def get_attack_coord
    puts "Enter your attack coord:"
    print '> '
    coord = get_input
    loop do
      if /([A-Z][1-9])/.match?(coord)
        return coord
      else 
        puts "That's not a valid coord to fire upon! Try again\n"
        puts "Enter a coordinate as a letter followed by a number, e.g. A1"
        print '> '
        coord = get_input
      end
    end
  end
  
  def try_again(size)
    puts "Try that again ;)"
    super
  end

  def lose
    puts 'So sorry, you lost.'
  end

  def print_hit(success, coord)
    if success
      puts "Congrats! You hit a ship at #{coord}!"
    else
      puts "You missed! So sad. Stop firing at whales at #{coord}."
    end
  end

  def get_input
    input = $stdin.gets
    if input.nil?
      return ""
    end
    input.chomp.upcase
  end
end
