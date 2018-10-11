require './test/test_helper'
require './lib/human_player'
require './lib/ship'
require './lib/ai_player'
require './lib/board'

class PlayerTest < Minitest::Test
  def setup
    @human = HumanPlayer.new
    @ai = AIPlayer.new
  end

  def test_has_ships
    skip
   @human.add_ship("A1", "A3", 3) # creates Ship object in this method and pass it to the board and adds it to ships array
    @ai.add_ship("A1", "A3", 3)
    # This is basically a passthrough - consider removing and just passing straing to Board method add_ship
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
    assert_instance_of Ship, @ai.ships[0]
  end

  def test_human_player_can_place_ships
    assert @human.add_ship("A1", "A2", 2)
    refute_equal [], @human.ships
    refute @human.add_ship("A1", "A4", 2)

  end
end
