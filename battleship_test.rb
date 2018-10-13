require './test/test_helper'
require './lib/battleship_game'

class BattleshipTest < Minitest::Test

  def test_run_a_game
    battleship = BattleshipGame.new()
    battleship.start()
  end
end
