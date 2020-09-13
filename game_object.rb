class GameObject

  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
  end

  def left
    @x
  end

  def set_left(x)
    @x = x
  end

  def right
    @x + @w
  end

  def set_right(x)
    @x = x - @w
  end

  def width
    @w
  end

  def height
    @h
  end

  def center_x
    @x + @w / 2
  end

  def top
    @y
  end

  def set_top(y)
    @y = y
  end

  def bottom
    @y + @h
  end

  def set_bottom(y)
    @y = y - @h
  end

  def center_y
    @y + @h / 2
  end
end
