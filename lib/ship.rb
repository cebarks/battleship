class Ship
  attr_reader :destroyed, :size, :hits, :owner

  def initialize(player, size)
    @owner = player
    @size = size
    @hits = 0
    @destroyed = false
  end

  def add_hit
    @hits += 1
    @destroyed = true if @hits >= @size
  end
end
