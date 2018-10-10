require './test/test_helper'
require 'pry'
require './lib/board'
require './lib/ship'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_default_size
    assert_equal 4, @board.size
  end

  def test_custom_size
    custom_board = Board.new(8)
    assert_equal 8, custom_board.size
  end

  def test_it_populates_keys
    @board.populate_keys

    expected = %w[A1 B1 C1 D1 A2 B2 C2 D2 A3 B3 C3 D3 A4 B4 C4 D4]

    assert_equal expected, @board.board_hash.keys
  end

  def test_print_board
    skip
    assert_output("\n" + '==========' + "\n" + '. 1 2 3 4 ' + "\n" + 'A' + "\n" + 'B' + "\n" + 'C' + "\n" + 'D' + "\n" + '==========' + "\n", '') do
      @board.print_board
    end
  end

  def test_print_boarders
    assert_output('==========' + "\n", '') do
      @board.print_boarders
    end
  end

  # def test_it_can_add_a_ship(coord_1, coord_2, ship)
  #   skip
  #   @board.add_ship("A1", "A2", Ship.new)
  #   assert_equal 1, @board.ships #???
  # end

  def test_it_can_validate_ship_placement
    @board.populate_keys
    assert_equal true, @board.is_placement_valid?('A1', 'A2', 2)
  end
end
