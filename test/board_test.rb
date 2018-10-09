require './test/test_helper'
require 'pry'
require './lib/board'

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

    expected = ["A1", "B1", "C1", "D1", "A2", "B2", "C2", "D2", "A3", "B3", "C3", "D3", "A4", "B4", "C4", "D4"]

    assert_equal expected, @board.board_hash.keys
  end

  def test_print_board
    Board.new(9).print_board
  end
end
