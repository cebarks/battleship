require './lib/cell_container'

class Board
  attr_reader :size, :board_hash

  def initialize(size = 4)
    if(size < 4)
      puts "WRONG SIZE LESS THAN 4!!!!!!!"
      exit!
    end
    @size = size
    @board_hash = Hash.new(nil)
    @allowed_letters = (alpha_hash[1]..alpha_hash[@size]).to_a
  end

  def populate_keys
    (1..size).each do |number|
      ('A'..alpha_hash[size]).each do |letter|
        @board_hash["#{letter}#{number}"] = CellContainer.new
      end
    end
  end

  def print_board
    print "\n"
    print_boarders
    print '. '

    (1..size).each do |num|
      print "#{num} "
    end

    print "\n"

    ('A'..alpha_hash[size]).each do |letter|
      print_row(letter)
    end

    print_boarders
  end

  def add_ship(coord_1, coord_2, ship)
    coord_1 = coord_1.upcase
    coord_2 = coord_2.upcase
    if is_placement_valid?(coord_1, coord_2, ship.size)
    end
  end

  def is_placement_valid?(coord_1, coord_2, ship_size)
    if !is_coord_valid(coord_1) || !is_coord_valid(coord_2) #If either coord isn't valid, return fail
      return false
    end

    distance = coord_distance(coord_1, coord_2)

    if distance == 0
      return false
    end

    if distance != ship_size
      return false
    end

    all_cells_empty = true

    coords_between(coord_1, coord_2).each do |coord|
      if !is_cell_empty?(coord)
        all_cells_empty = false
      end
    end

    if !all_cells_empty
      return false
    end

    true
  end

  def is_cell_empty?(coord)
    @board_hash[coord].empty?
  end

  def coords_between(coord_1, coord_2)
    n1, l1 = coord_1[1], coord_1[0]
    n2, l2 = coord_2[1], coord_2[0]

    result = []

    if n1==n2
      (l1..l2).each do |x|
        result << "#{x}#{n1}"
      end
    elsif l1==l2
      (n1..n2).each do |x|
        result << "#{l1}#{x}"
      end
    end

    result
  end

  def coord_distance(coord_1, coord_2)
    n1, l1 = coord_1[1], coord_1[0]
    n2, l2 = coord_2[1], coord_2[0]

    distance = 0

    if n1==n2
      inverted = alpha_hash.invert
      distance = (inverted[l1] - inverted[l2]).abs
    elsif l1==l2
      distance = (n1.to_i - n2.to_i).abs
    end

    distance
  end

  def is_coord_valid?(coord)
    let = coord[0]
    num = coord[1]

    if num > size || num < 0
      return false
    end
    if !@allowed_letters.include?(let)
      return false
    end
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
