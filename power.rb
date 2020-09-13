require_relative 'constants'

require_relative 'sprite'

class Power < Sprite

  attr_accessor :destroyed
  attr_reader :type

  def initialize(x, y, vy, type, owner)
    super(x, y, Constants::POWER_WIDTH, Constants::POWER_HEIGHT)

    @vy = vy
    @type = type
    @owner = owner
    @image = Constants::POWER_TYPES[type]
  end

  def move_down_in(frame)
    @y += @vy
    @owner.delete_power(self) if bottom > frame.bottom
  end
end

