require './lib/cell_container'

class Board
  attr_reader :size, :board_hash

  def initialize(size = 4)
    @size = size
    @board_hash = Hash.new(nil)
  end

  def populate_keys
    (1..@size).each do |number|
      ('A'..alpha_hash[size]).each do |letter|
        @board_hash["#{letter}#{number}"] = CellContainer.new
      end
    end
  end

  def print_board
    print "\n"
    print_boarders
    print '. '
    (1..@size).each do |num|
      print "#{num} "
    end
    print "\n"

    ('A'..alpha_hash[size]).each do |letter|
      print_row(letter)
    end

    print_boarders

  end

  def print_boarders
    (@size * 2 + 2).times do
      print '='
    end
    print "\n"
  end

  def print_row(letter)
    puts letter
  end



  def alpha_hash
    alpha_hash = {}
    counter = 1
    ('A'...'Z').each do |x|
      alpha_hash[counter] = x
      counter += 1
    end
    alpha_hash
  end
end
