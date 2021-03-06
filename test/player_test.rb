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
    @ai.add_guess("A1", false)
    @ai.add_guess("B2", false)
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
  
  def test_ai_always_starts_on_b2
    assert_equal "B2", @ai.get_attack_coord
  end
  
  def test_ai_can_pick_an_adjacent_coordinate
    @human.fire("A2")
    @human.fire("A1")
    @ai.add_guess("A1", true)
    
    coord = ''
    loop do
      coord = @ai.get_attack_coord
      break if @human.board.is_coord_valid?(coord) && !@human.hit?(coord)
    end
    
    assert_equal "B1", coord
  end
  
  def test_ai_can_pick_a_different_adjacent_coordinate
    @human.fire("B1")
    @human.fire("A1")
    @ai.add_guess("A1", true)
  
    coord = ''
    loop do
      coord = @ai.get_attack_coord
      break if @human.board.is_coord_valid?(coord) && !@human.hit?(coord)
    end
  
    assert_equal "A2", coord
  end
  
  def test_can_store_guesses
    assert_equal 0, @ai.guesses.size
    @ai.add_guess("A1", false)
    assert_equal [["A1", false]], @ai.guesses
  end
  
  def test_it_can_return_information_from_guesses
    @ai.add_guess("A1", false)
    assert_equal false, @ai.last_guess_hit?
    assert_equal "A1", @ai.last_guess
  end

end
