require 'gosu'

require_relative 'sprite'

class Ball < Sprite

  attr_accessor :vx, :vy
  attr_accessor :stuck_position
  attr_writer :penetrating
  attr_reader :stuck

  def initialize(x, y, vx, vy, owner)
    super(x, y, Constants::BALL_WIDTH, Constants::BALL_HEIGHT)

    @owner = owner
    @vx = vx
    @vy = vy
    @image = Constants::IMAGES[:ball_cyan]
    @image_penetrating = Constants::IMAGES[:ball_red]

    @stuck = false
    @stuck_position = Constants::PADDLE_WIDTH / 2 - Constants::BALL_WIDTH / 2
    @penetrating = false
    @stuck_timer = 0
    @hit_counter = 0
  end

  def stuck=(a_value)
    @stuck = a_value

    @stuck_timer = if @stuck
                     Constants::BALL_STUCK_TIMEOUT
                   else
                     0
                   end
  end

  def penetrating?
    @penetrating
  end

  def dec_stuck_timer
    @stuck_timer -= 1
    self.stuck = false if @stuck_timer < 1
  end

  def inc_hit_counter
    @hit_counter += 1
    if @hit_counter > Constants::BALL_HITS_TO_INCREASE_SPEED
      # increase_vertical_speed if @vy < Constants::BALL_MAX_SPEED_Y
      @hit_counter = 0
    end
  end

  def move_in(frame)
    @x += @vx
    @y -= @vy

    if left < frame.left
      set_left(frame.left)
    elsif right > frame.right
      set_right(frame.right)
    end

    if top < frame.top
      set_top(frame.top)
    elsif bottom > frame.bottom
      set_bottom(frame.bottom)
    end

    case
    when left == frame.left
      reflect_horizontal
    when right == frame.right
      reflect_horizontal
    when top == frame.top
      reflect_vertical
    when bottom == frame.bottom
      @owner.delete_ball(self)
    end
  end

  def reflect_horizontal
    @vx *= -1
  end

  def reflect_vertical
    @vy *= -1
  end

  def reflect_on (paddle)
    @vy *= -1
    @vx = -(paddle.center_x - center_x) * 1 / 6
  end

  def increase_vertical_speed
    @vy *= 1.1
  end

  def draw
    @penetrating ? @image_penetrating.draw(@x, @y, 0) : super
  end

end
