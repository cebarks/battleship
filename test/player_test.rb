require './test/test_helper'
require './lib/player'
require './lib/ship'

class PlayerTest < Minitest::Test
  def setup
    @human = HumanPlayer.new
    @ai = AIPlayer.new
  end

  def test_has_ships
    @human.add_ship("A1", "A3", 3) # creates Ship object in this method and pass it to the board and adds it to ships array
    @ai.add_ship("A1", "A3", 3)
    assert_equal 1, @human.ships.length
    assert_equal 1, @ai.ships.length
  end

  def test_has_board
    assert_instance_of Board, @human.board
    assert_instance_of Board, @ai.board
  end

  def test_ai_can_place_ships
    @ai.place_ships
    refute_equal [], @ai.ships
  end

  def test_player_can_place_ships
    skip
    @human.place_ships
    refute_equal [], @human.ships
  end
end
