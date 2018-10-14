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
  
  def test_it_displays_correct_character_when_empty
    assert_equal ' ', @cell_container.get_char_to_display(false)
    @cell_container.hit_status = true
    assert_equal 'M', @cell_container.get_char_to_display(false)
  end
  
  def test_it_displays_correct_character_when_contains_ship
    @cell_container.content = Ship.new(nil, 2)
    assert_equal ' ', @cell_container.get_char_to_display(false)
    assert_equal 'S', @cell_container.get_char_to_display(true)
    @cell_container.hit_status = true
    assert_equal 'H', @cell_container.get_char_to_display(false)
    @cell_container.content.add_hit
    @cell_container.content.add_hit
    assert_equal 'D', @cell_container.get_char_to_display(false)
  end
  
  
end
