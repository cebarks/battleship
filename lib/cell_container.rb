class CellContainer
  def initialize(content = nil)
    @content = content
  end

  def empty?
    @content.nil?
  end
end
