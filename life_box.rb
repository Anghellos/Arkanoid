require_relative 'game_object'

class Life_Box < GameObject

  def initialize(x, y, w, h)
    super(x, y, w, h)

    @image = Constants::IMAGES[:lives]

    @value = 0
  end

  def value=(a_value)
    @value = a_value
  end

  def draw
    x = @x
    for i in 1..@value
      @image.draw(x, @y, 0)
      x += @w
    end
  end
end