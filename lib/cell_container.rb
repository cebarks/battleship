class CellContainer
  attr_accessor :content, :hit_status

  def initialize(content = nil)
    @content = content
    @hit_status = false
  end

  def empty?
    @content.nil?
  end

  def ship_hit?
    return false if empty?

    @content.is_a?(Ship) && @hit_status
  end

  def hit
    @content.add_hit unless empty?
  end

  def get_char_to_display(ships)
    if @content.is_a?(Ship)
      if @hit_status
        if @content.destroyed
          'D'
        else
          'H'
        end
      elsif ships
       'S'
      else
        ' '
      end
    elsif @hit_status
      'M'
    else
      ' '
    end
  end
end
