class CellContainer
  attr_accessor :content, :hit_status

  def initialize(content = nil)
    @content = content
    @hit_status = false
  end

  def empty?
    @content.nil?
  end

  def get_char_to_display

    if @content.is_a?(Ship)
      if @hit_status
        "H"
      else
        "S"
      end
    elsif hit_status
      "M"
    else
      " "
    end
  end
end
