require './test/test_helper'
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

  def test_invalid_size
    assert_output("WRONG SIZE LESS THAN 4!!!!!!!\n",'') do
      Board.new(3)
    end
  end

  def test_custom_size
    custom_board = Board.new(8)
    assert_equal 8, custom_board.size
  end

  def test_it_populates_keys
    expected = %w[A1 B1 C1 D1 A2 B2 C2 D2 A3 B3 C3 D3 A4 B4 C4 D4]

    assert_equal expected, @board.board_hash.keys
  end

  def test_print_empty_board
    skip # Atom auto-deletes necessary trailing whitespace
    @board.print_board
    expected =%(
==========
. 1 2 3 4
A
B
C
D
==========
)
    assert_output(expected, '') do
      @board.print_board
    end
  end

  def test_print_boarders
    assert_output("\n==========\n", '') do
      @board.print_boarders
    end
  end

  def test_it_can_add_a_ship
    @board.add_ship('A1', 'A2', Ship.new(nil, 2))
    assert_equal false, @board.board_hash['A1'].empty?
    assert_equal false, @board.board_hash['A2'].empty?
  end

  def test_it_can_validate_ship_placement
    assert_equal true, @board.is_placement_valid?('A1', 'A2', 2)
    assert_equal true, @board.is_placement_valid?('B1', 'B3', 3)
    assert_equal true, @board.is_placement_valid?('A1', 'B1', 2)
    assert_equal false, @board.is_placement_valid?('A1', 'A4', 6)
    assert_equal false, @board.is_placement_valid?('A1', 'A4', 2)
    assert_equal false, @board.is_placement_valid?('A1', 'C3', 4)
    # add test to make sure is_palcement_valid returns false if adding ontop of another ship
  end

  def test_it_can_mark_a_coordinate_as_hit
    refute @board.hit?("A1")
    @board.hit("A1")
    assert @board.hit?("A1")
  end

end
