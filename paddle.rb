require 'gosu'

require_relative 'sprite'

class Paddle < Sprite

  attr_writer :with_laser_gun
  attr_accessor :sticky

  def initialize(x, y, vx, owner)
    super(x, y, Constants::PADDLE_WIDTH, Constants::PADDLE_HEIGHT)

    @vx = vx
    @owner = owner
    @image = Constants::IMAGES[:paddle_red]

    @sticky = false
    @with_laser_gun = false
    @last_shot = 0
  end

  def speed
    @vx
  end

  def with_laser_gun?
    @with_laser_gun
  end

  def move_left_in(frame)
    @x -= @vx
    set_left(frame.left) if left < frame.left
  end

  def move_right_in(frame)
    @x += @vx
    set_right(frame.right) if right > frame.right
  end

  def width=(w)
    @w = w
  end

  def with_laser_gun(value)
    @with_laser_gun = value
  end

  def play_sound
    Constants::play_sound(Constants::SOUND_EFFECTS[:paddle_red_new])
  end

  def draw
    temp_image = if @with_laser_gun
                   Constants::IMAGES[:paddle_orange_laser]
                 elsif @w == Constants::PADDLE_WIDE_WIDTH
                   Constants::IMAGES[:paddle_red_wide]
                 else
                   @image
                 end

    image = temp_image[Gosu.milliseconds / 100 % temp_image.size]
    image.draw(@x, @y, 0)
  end
end
