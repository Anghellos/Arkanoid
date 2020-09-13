require_relative 'sprite'

class Laser_Beam < Sprite

  attr_accessor :destroyed

  def initialize(x, y, v, owner)
    super(x, y, Constants::LASER_WIDTH, Constants::LASER_HEIGHT)

    @vx = v
    @owner = owner

    @image = Constants::IMAGES[:laser_beam]
  end


  def move_up_in(frame)
    @y -= @vx

    @owner.delete_laser(self) if top < frame.top
  end
end


