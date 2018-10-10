require './test/test_helper'

require './lib/ship'
require './lib/player'

class ShipTest < Minitest::Test
  def setup
    @player = Player.new
    @ship = Ship.new(@player, 2)
  end

  def test_ship_has_size
    assert_equal 2, @ship.size
  end

  def test_ship_has_owner
    assert_equal @player, @ship.owner
  end

  def test_can_add_hit_to_ship
    assert_equal 0, @ship.hits
    @ship.add_hit
    assert_equal 1, @ship.hits
    @ship.add_hit
    assert_equal 2, @ship.hits
  end

  def test_if_ship_is_destroyed
    refute @ship.destroyed
    @ship.add_hit
    @ship.add_hit
    assert @ship.destroyed
  end
end
