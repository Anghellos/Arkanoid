class GameOverScreen

  def initialize(owner)
    @owner = owner
  end

  def on_button_down(id)
    case id
    when Gosu::KbN
      @owner.new_game
    end
  end

  def on_update
    # Constants::SOUND_EFFECTS[:game_over].play
  end

  def on_draw
    Constants::IMAGES[:game_over].draw(0, 0, 0)
  end
end