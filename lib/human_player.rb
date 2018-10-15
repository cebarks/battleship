require './lib/ship'
require './lib/board'
require './lib/repl'
require './lib/player'

class HumanPlayer < Player
  
  def try_again(size)
    puts "Try that again ;)"
    super
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
        puts "Enter a coordinate as a letter followed by a number, e.g. A1"
        print '> '
        coord = get_input
      end
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
