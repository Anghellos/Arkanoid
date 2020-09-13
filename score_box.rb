require_relative 'constants'

class Score_Box

  def initialize
    @value = 0
  end

  def value=(a_value)
    @value = a_value
  end

  def draw
    x = Constants::SCORE_BOX_X + Constants::SCORE_BOX_WIDTH

    @value.to_s.reverse.chars.each do |char|
      image = Constants::NUMBER_IMAGES[char]
      image.draw(x, Constants::SCORE_BOX_Y, 0)
      x -= Constants::NUMBER_WIDTH
    end
  end
end
