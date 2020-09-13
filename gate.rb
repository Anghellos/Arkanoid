require 'gosu'

require_relative 'constants'
require_relative 'sprite'

class Gate < Sprite
  def initialize(x, y, image)
    super(x, y, Constants::BRICK_WIDTH , Constants::BRICK_HEIGHT)

    @image = image
  end
end