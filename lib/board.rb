require './lib/cell_container'
require './lib/coords'

class Board
  include Coords
  attr_reader :size, :board_hash

  def initialize(size = 4)
    if size < 4 # Better way to do this
      puts 'WRONG SIZE LESS THAN 4!!!!!!!'
      size = 4
    end
    @size = size
    @board_hash = Hash.new(nil)
    @allowed_letters = (alpha_hash[1]..alpha_hash[@size]).to_a

    populate_keys
  end

  def populate_keys
    (1..size).each do |number|
      ('A'..alpha_hash[size]).each do |letter|
        @board_hash["#{letter}#{number}"] = CellContainer.new
      end
    end
  end

  def print_board(ships)
    print_boarders
    print '.'

    (1..size).each do |num|
      print " #{num}"
    end
    ('A'..alpha_hash[size]).each do |letter|
      print "\n"
      print_row(letter, ships)
    end

    print_boarders
  end

  def print_row(letter, ships)
    row_keys = @board_hash.keys.select do |key|
      key.include?(letter)
    end

    row_keys.sort!
    row = row_keys.map do |key|
      @board_hash[key].get_char_to_display(ships)
    end

    print letter
    row.each do |char|
      print ' ' + char
    end
  end

  def print_boarders
    print "\n"
    (@size * 2 + 2).times do
      print '='
    end
    print "\n"
  end

  def add_ship(coord_1, coord_2, ship)
    coord_1 = coord_1.upcase
    coord_2 = coord_2.upcase
    if is_placement_valid?(coord_1, coord_2, ship.size)
      coords_between(coord_1, coord_2).each do |coord|
        @board_hash[coord].content = ship
      end
      true
    else
      false
    end
  end

  def is_cell_empty?(coord)
    @board_hash[coord].empty?
  end

  def hit?(coord)
    @board_hash[coord].hit_status
  end

  def hit(coord)
    @board_hash[coord].hit
    @board_hash[coord].hit_status = true
  end

  def ship_hit?(coord)
    @board_hash[coord].ship_hit?
  end
end
