require 'gosu'

require_relative 'constants'
require_relative 'welcome_screen'
require_relative 'game_screen'
require_relative 'game_over_screen'

class Arkanoid < Gosu::Window

  def initialize
    super(Constants::WND_WIDTH, Constants::WND_HEIGHT + Constants::SCORE_BOX_HEIGHT)

    self.caption = Constants::CAPTION
    self.update_interval = Constants::UPDATE_INTERVAL

    @welcome_screen = WelcomeScreen.new(self)
    @game_screen = GameScreen.new(self)
    @game_over_screen = GameOverScreen.new(self)
    @active_screen = @welcome_screen
  end

  def start_game
    @active_screen = @game_screen
  end

  def game_over
    @active_screen = @game_over_screen
  end

  def on_button_down(id)
    case id
    when Gosu::KbM
      Constants::toggle_mute
      return
    when Gosu::KbEscape
      close
    end

    @active_screen.on_button_down(id) if @active_screen
  end

  def on_update
    @active_screen.on_update if @active_screen
  end

  def on_draw
    @active_screen.on_draw if @active_screen
  end

  alias button_down on_button_down
  alias update on_update
  alias draw on_draw
end

Arkanoid.new.show