require './test/test_helper'
require './lib/repl'

class ReplTest < Minitest::Test
  def setup
    @repl = Repl.new
  end

  def test_trigger_play
    assert_equal :play, @repl.get_response_from_trigger("p")
    assert_equal :play, @repl.get_response_from_trigger("play")
  end

  def test_trigger_instructions
    assert_equal :instructions, @repl.get_response_from_trigger("i")
    assert_equal :instructions, @repl.get_response_from_trigger("instructions")
  end

  def test_trigger_quit
    assert_equal :quit, @repl.get_response_from_trigger("q")
    assert_equal :quit, @repl.get_response_from_trigger("quit")
  end

  def test_invalid_trigger_returns_invalid
    assert_equal :invalid, @repl.get_response_from_trigger(rand((1..1000)))
  end
end
