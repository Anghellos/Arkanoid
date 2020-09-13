require_relative 'game_object'

class Sprite < GameObject

  def initialize(x, y, w, h)
    super(x, y, w, h)

    @image = nil
  end

  def set_width(w)
    @w = w
  end

  def set_height(h)
    @h = h
  end

  def set_image(image)
    @image = image
  end

  def collision_axe(other)
    dleft = (self.right - other.left).abs
    dright = (self.left - other.right).abs
    dtop = (self.bottom - other.top).abs
    dbottom = (self.top - other.bottom).abs

    dmin = [dleft, dright, dtop, dbottom].min

    if dmin == dtop || dmin == dbottom
      :y_axe
    elsif dmin == dleft || dmin == dright
      :x_axe
    else
      :y_axe
    end
  end

  def collide_with?(other)
    # x_overlap = [0, [right, other.right].min - [left, other.left].max].max
    # y_overlap = [0, [bottom, other.bottom].min - [top, other.top].max].max
    # x_overlap * y_overlap != 0

    # !(self.right < other.x || self.x > other.right || self.bottom < other.y || self.y > other.bottom)

    (other.right >= self.left && other.left <= self.right) && (other.bottom >= self.top && other.top <= self.bottom)
  end

  def draw
    @image.draw(@x, @y, 0)
  end

  def draw_animation
    image = @image[Gosu.milliseconds / 100 % @image.size]
    image.draw(@x, @y, 0)
  end

end