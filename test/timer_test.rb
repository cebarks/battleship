require './test/test_helper'
require './lib/timer'


class TimerTest < Minitest::Test
  def test_timer_1_second
    timer = Timer.new
    timer.start
    sleep(1)
    timer.stop

    assert 1, timer.total(0)
  end
end
