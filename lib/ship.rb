class Ship
  attr_reader :destroyed, :size

  def initialize(player, size)
    @player = player
    @size = size
    @hits = 0
    @destroyed = false
  end

  def add_hit
    @hits += 1
    @destroyed = true if @hits >= @size
  end
end
