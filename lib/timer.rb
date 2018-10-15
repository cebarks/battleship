class Timer
  def initialize
    @start_time = 0
    @end_time = 0
  end

  def start
    @start_time = Time.now
    self
  end

  def stop
    @end_time = Time.now
    self
  end

  def total(round)
    (@end_time - @start_time).round(round)
  end
end
