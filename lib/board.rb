require './lib/cell_container'

class Board
  attr_reader :size, :board_hash

  def initialize(size = 4)
    @size = size
    @board_hash = Hash.new(nil)
  end

  def populate_keys
    alpha_hash = {}
    counter = 1
    ('A'...'Z').each do |x|
      alpha_hash[counter] = x
      counter += 1
    end

    (1..@size).each do |number|
      ('A'..alpha_hash[size]).each do |letter|
        @board_hash["#{letter}#{number}"] = CellContainer.new
      end
    end
  end

  def printBoard

  end
end
