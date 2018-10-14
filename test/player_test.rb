require './test/test_helper'
require './lib/human_player'
require './lib/ship'
require './lib/ai_player'
require './lib/board'
require './lib/battleship_game'

class PlayerTest < Minitest::Test
  def setup
    @human = HumanPlayer.new
    @ai = AIPlayer.new
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

  def test_fire
    @ai.add_ship("A1", "A2", 2)
    @human.add_ship("B1", "B2", 2)
    refute @ai.fire("D4")
    refute @human.fire("D4")
    assert @ai.fire("A1")
    assert @human.fire("B1")
  end

  def test_ai_can_pick_valid_attack_coordinates
    assert (/([A-Z][1-9])/.match?(@ai.get_attack_coord))
  end

  def test_player_can_hit_ship
    refute @ai.hit?("A1")
    refute @human.hit?("B1")
    @ai.hit("A1")
    @human.hit("B1")
    assert @ai.hit?("A1")
    assert @human.hit?("B1")
  end



end
