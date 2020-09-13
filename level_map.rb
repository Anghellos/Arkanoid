require_relative 'constants'

require_relative 'game_object'
require_relative 'brick'

class LevelMap < GameObject

  def initialize(frame, level)
    super(frame.left, frame.top, frame.width, frame.height)

    @level = level
    @bricks = []

    load
  end

  def draw
    @bricks.each { |brick| brick.draw }
  end

  def bricks_empty?
    @bricks.count { |brick| brick.lives < Constants::BRICK_LIVES_THRESHOLD } <= 0
  end

  def each_brick
    @bricks.each do |brick|
      yield brick
    end
  end

  def delete_brick(brick)
    @bricks.delete(brick)
  end

  private

  def load
    x, y = @x, @y

    File.open(Constants::LEVEL_PATH + @level.to_s).readlines.each do |row|
      row.strip.each_char do |char|
        @bricks << Brick.new(x, y, char.to_sym) unless char == '.'
        x += Constants::BRICK_WIDTH
      end
      y += Constants::BRICK_HEIGHT
      x = @x
    end

    powers = Constants::POWER_TYPES.keys
    (@bricks.count * Constants::POWER_PERCENT).to_int.times do
      brick = @bricks[rand(@bricks.count)]
      next if brick.lives > Constants::BRICK_LIVES_THRESHOLD

      brick.power = powers[rand(powers.count)]
    end
  end

end
