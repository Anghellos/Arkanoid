require 'gosu'

require_relative 'constants'
require_relative 'sprite'

class Brick < Sprite

  attr_reader :lives
  attr_reader :points
  attr_reader :power

  def initialize(x, y, type)
    super(x, y, Constants::BRICK_WIDTH, Constants::BRICK_HEIGHT)

    @image = Constants::BRICK_TYPES[type][:image]

    @lives = Constants::BRICK_TYPES[type][:lives]
    @points = Constants::BRICK_TYPES[type][:points]

    @power = nil
  end

  def power=(a_value)
    @power = a_value
  end

  def hit
    @lives -= 1
    if @lives < 1
      Constants::play_sound(Constants::SOUND_EFFECTS[:brick_destroyed])
    else
      Constants::play_sound(Constants::SOUND_EFFECTS[:brick_hit])
    end
  end

end
