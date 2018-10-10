require './test/test_helper'

require './lib/cell_container'
require './lib/ship'

class CellContainerTest < Minitest::Test
  def setup
    @cell_container = CellContainer.new
  end

  def test_it_exists
    assert_instance_of CellContainer, @cell_container
  end

  def test_is_empty
    assert @cell_container.empty?
    @cell_container.content = 1
    refute @cell_container.empty?
  end

  def test_can_hold_ship_as_content
    assert @cell_container.empty?
    @cell_container.content = Ship.new(nil, 2)
    refute @cell_container.empty?
  end
end
