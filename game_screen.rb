require 'gosu'

require_relative 'constants'
require_relative 'gate'
require_relative 'paddle'
require_relative 'ball'
require_relative 'brick'
require_relative 'life_box'
require_relative 'score_box'
require_relative 'power'
require_relative 'laser_beam'
require_relative 'level_map'

class GameScreen

  def initialize(owner)
    @owner = owner

    @game_frame = GameObject.new(Constants::FRAME_X, Constants::FRAME_Y, Constants::FRAME_WIDTH, Constants::FRAME_HEIGHT)
    @score_box = Score_Box.new
    @lives_box = Life_Box.new(Constants::LIFE_BOX_X, Constants::LIFE_BOX_Y, Constants::LIFE_BOX_WIDTH, Constants::LIFE_BOX_HEIGHT)

    new_game
  end

  def on_button_down(id)
    case id
    when Gosu::KbSpace
      @balls.each do |ball|
        ball.stuck = false
      end
      if @paddle.with_laser_gun?
        @laser_beams << Laser_Beam.new(@paddle.left + Constants::LASER_LEFT_X, @paddle.top + Constants::LASER_HEIGHT, Constants::LASER_SPEED, self)
        @laser_beams << Laser_Beam.new(@paddle.left + Constants::LASER_RIGHT_X, @paddle.top + Constants::LASER_HEIGHT, Constants::LASER_SPEED, self)
      end
    when Gosu::KbP
      @game_paused = !@game_paused
    when Gosu::KbEqual
      next_level
    when Gosu::KbMinus
      previous_level if @level > 0
    end
  end

  def on_update
    return if @game_paused

    if @balls.empty?
      @lives -= 1
      Constants::play_sound(Constants::SOUND_EFFECTS[:life_lost])
      revive if @lives >= 0
    end

    case
    when @lives < 0
      @owner.game_over
      return
    when @level_map.bricks_empty?
      next_level
    end

    if !@gate_next_level.nil? && @paddle.right == @gate_next_level.left
      @gate_next_level = nil
      next_level
    end

    @paddle.move_left_in(@game_frame) if @owner.button_down? Gosu::KB_LEFT
    @paddle.move_right_in(@game_frame) if @owner.button_down? Gosu::KB_RIGHT

    check_ball_hit_paddle
    check_ball_hit_brick
    check_laser_beam_hit_brick
    check_power_hit_paddle

    @lives_box.value = @lives
    @score_box.value = @score
  end

  def check_ball_hit_paddle
    @balls.each do |ball|
      if ball.stuck
        ball.dec_stuck_timer
        break
      end

      ball.move_in(@game_frame)

      if ball.collide_with?(@paddle)
        ball.inc_hit_counter
        ball.reflect_vertical
        ball.vx = ball.vx < 0 ? -1 : 1 * Constants::BALL_SPEED_X
        ball.vy = Constants::BALL_SPEED_Y if ball.vy < Constants::BALL_SPEED_Y

        paddle_left = Sprite.new(@paddle.left, @paddle.top, Constants::PADDLE_EDGE, @paddle.height)
        paddle_right = Sprite.new(@paddle.right - Constants::PADDLE_EDGE, @paddle.top, Constants::PADDLE_EDGE, @paddle.height)

        if ball.collide_with?(paddle_left)
          ball.vx = -8
        elsif ball.collide_with?(paddle_right)
          ball.vx = 8
        end

        if @paddle.sticky
          ball.stuck = true
          ball.stuck_position = ball.left - @paddle.left
        else
          @paddle.play_sound
        end
      end
    end
  end

  def check_ball_hit_brick
    @balls.each do |ball|
      @level_map.each_brick do |brick|
        if ball.collide_with?(brick)
          brick.hit
          ball.inc_hit_counter

          ball.reflect_vertical if ball.collision_axe(brick) == :y_axe unless ball.penetrating?
          ball.reflect_horizontal if ball.collision_axe(brick) == :x_axe unless ball.penetrating?

          if ball.penetrating? || brick.lives.zero?
            @powers << Power.new(brick.left, brick.top, Constants::POWER_SPEED, brick.power, self) unless brick.power.nil?
            # @powers << Power.new(brick.left, brick.top, Constants::POWER_SPEED, :b, self)
            @level_map.delete_brick(brick)
            @score += brick.points
          end

          break
        end
      end
    end
  end

  def check_laser_beam_hit_brick
    @laser_beams.each do |laser_beam|
      laser_beam.move_up_in(@game_frame)

      @level_map.each_brick do |brick|
        if laser_beam.collide_with?(brick)
          brick.hit
          if brick.lives.zero?
            # @powers << Power.new(brick.left, brick.top, Constants::POWER_SPEED, brick.power, self) unless brick.power.nil?
            @level_map.delete_brick(brick)
          end
          @laser_beams.delete(laser_beam)
          @score += brick.points
        end
      end
    end
  end

  def check_power_hit_paddle
    @powers.each do |power|
      power.move_down_in(@game_frame)

      if power.collide_with?(@paddle)
        delete_power(power)

        case power.type
        when :b
          @gate_next_level = Gate.new(Constants::GATE_NEXT_LEVEL_X, Constants::GATE_NEXT_LEVEL_Y, Constants::IMAGES[:gate_next_level])
        when :c
          @paddle = Paddle.new(@paddle.left, @paddle.top, @paddle.speed, self)
          @paddle.sticky = true
        when :d
          @balls << Ball.new(@balls[0].left, @balls[0].top, 0, 8, self)
          @balls << Ball.new(@balls[0].left, @balls[0].top, 8, 2, self)
          @balls << Ball.new(@balls[0].left, @balls[0].top, 0, -8, self)
          @balls << Ball.new(@balls[0].left, @balls[0].top, -8, -2, self)

          @balls << Ball.new(@balls[0].left, @balls[0].top, 5, 5, self)
          @balls << Ball.new(@balls[0].left, @balls[0].top, -5, 5, self)
          @balls << Ball.new(@balls[0].left, @balls[0].top, 5, -5, self)
          @balls << Ball.new(@balls[0].left, @balls[0].top, -5, -5, self)
          delete_ball(@balls.first)
        when :e
          power_for_paddle
          @paddle.width = Constants::PADDLE_WIDE_WIDTH
          @paddle.set_left(@game_frame.right - Constants::PADDLE_WIDE_WIDTH) if @paddle.left > @game_frame.right - Constants::PADDLE_WIDE_WIDTH
        when :l
          power_for_paddle
          @paddle.with_laser_gun = true
        when :m
          @balls.each { |ball| ball.penetrating = true }
        when :p
          @lives += 1
        end
      end
    end
  end

  def on_draw
    Constants::IMAGES[:one_up].draw(Constants::SCORE_BOX_WIDTH, 0, 0)
    Constants::IMAGES[:background_blue].draw(0, Constants::SCORE_BOX_HEIGHT, 0)
    @score_box.draw
    @lives_box.draw
    @level_map.draw
    @gate_next_level.draw_animation if !@gate_next_level.nil?
    @balls.each do |ball|
      if ball.stuck
        ball.set_left @paddle.left + ball.stuck_position
        ball.set_top @paddle.top - Constants::BALL_STUCK_Y
      end
      ball.draw
    end
    @laser_beams.each { |laser| laser.draw }
    @powers.each { |power| power.draw_animation }
    @paddle.draw
  end

  def new_game
    @score = 0
    @lives = 3
    @level = 1
    @level_map = LevelMap.new(@game_frame, @level)

    @game_paused = false

    Constants::play_sound(Constants::SOUND_EFFECTS[:new_game])
    revive
  end

  def revive
    @balls = []
    @powers = []
    @laser_beams = []

    @paddle = Paddle.new(Constants::PADDLE_START_POS_X, Constants::PADDLE_START_POS_Y, Constants::PADDLE_SPEED, self)
    @ball = Ball.new(@paddle.center_x - Constants::BALL_STUCK_X, @paddle.top - Constants::BALL_STUCK_Y + Constants::SCORE_BOX_HEIGHT, Constants::BALL_SPEED_X, Constants::BALL_SPEED_Y, self)
    @ball.stuck = true
    @balls << @ball
  end

  def next_level
    return if @level > 9

    @level += 1
    puts @level
    @level_map = LevelMap.new(@game_frame, @level)
    @score += Constants::BONUS_NEXT_LEVEL

    revive
  end

  def previous_level
    @level -= 1 if @level > 1
    @level_map = LevelMap.new(@game_frame, @level)
    @score += Constants::BONUS_NEXT_LEVEL

    revive
  end

  def power_for_paddle
    @paddle = Paddle.new(@paddle.left, @paddle.top, @paddle.speed, self)
    @balls.each { |ball| ball.stuck = false }
  end

  def delete_ball(a_ball)
    @balls.delete(a_ball)
  end

  def delete_laser(a_laser)
    @laser_beams.delete(a_laser)
  end

  def delete_power(a_power)
    @powers.delete(a_power)
  end

end