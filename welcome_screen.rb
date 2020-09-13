require_relative 'constants'

class WelcomeScreen

  def initialize(owner)
    @owner = owner
  end

  def on_button_down(id)
    case id
    when Gosu::KbN
      @owner.start_game
      Constants::SOUND_EFFECTS[:welcome_screen].stop()
    end
  end

  def on_update
    Constants::play_sound(Constants::SOUND_EFFECTS[:welcome_screen])
  end

  def on_draw
    Constants::IMAGES[:welcome_screen].draw(0, Constants::SCORE_BOX_HEIGHT, 0)
  end
end