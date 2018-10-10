class CellContainer
  attr_accessor :content

  def initialize(content = nil)
    @content = content
  end

  def empty?
    @content.nil?
  end
end
