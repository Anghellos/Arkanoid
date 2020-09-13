module Constants
  CAPTION = 'Arkanoid'
  WND_WIDTH = 644
  WND_HEIGHT = 691
  UPDATE_INTERVAL = 33.33333 # => 30 FPS

  SCORE_BOX_X = 40
  SCORE_BOX_Y = 25
  SCORE_BOX_WIDTH = 120
  SCORE_BOX_HEIGHT = 46

  BONUS_NEXT_LEVEL = 500

  FRAME_X = 23
  FRAME_Y = 23 + SCORE_BOX_HEIGHT
  FRAME_WIDTH = WND_WIDTH - FRAME_X * 2
  FRAME_HEIGHT = WND_HEIGHT - FRAME_Y + SCORE_BOX_HEIGHT

  GATE_NEXT_LEVEL_X = 621
  GATE_NEXT_LEVEL_Y = 621
  GATE_NEXT_LEVEL_WIDTH = 8
  GATE_NEXT_LEVEL_HEIGHT = 40

  BALL_WIDTH = BALL_HEIGHT = 13
  BALL_STUCK_X = 7
  BALL_STUCK_Y = 13
  BALL_SPEED_X = 2
  BALL_SPEED_Y = 8
  BALL_MAX_SPEED_Y = BALL_SPEED_Y * 2
  BALL_HITS_TO_INCREASE_SPEED = 10
  BALL_STUCK_TIMEOUT = 100 # FPS

  PADDLE_WIDTH = 92
  PADDLE_HEIGHT = 23
  PADDLE_WIDE_WIDTH = 137
  PADDLE_EDGE = 20
  PADDLE_START_POS_X = (FRAME_WIDTH - PADDLE_WIDTH) / 2
  PADDLE_START_POS_Y = 620 + SCORE_BOX_HEIGHT
  PADDLE_SPEED = 12

  BRICK_WIDTH = 46
  BRICK_HEIGHT = 23

  BRICK_LIVES_INFINITE = 0xFFFF #65535
  BRICK_LIVES_THRESHOLD = BRICK_LIVES_INFINITE / 2

  LIFE_BOX_WIDTH = 46
  LIFE_BOX_HEIGHT = 20
  LIFE_BOX_X = FRAME_X
  LIFE_BOX_Y = WND_HEIGHT + SCORE_BOX_HEIGHT - LIFE_BOX_HEIGHT

  LIVES_AT_START = 3

  POWER_WIDTH = 45
  POWER_HEIGHT = 20
  POWER_SPEED = 5
  POWER_PERCENT = 0.1

  LASER_WIDTH = 5
  LASER_HEIGHT = 16
  LASER_LEFT_X = 19
  LASER_RIGHT_X = 59
  LASER_SPEED = 8

  LEVEL_PATH = 'levels/'

  IMAGES = {
      welcome_screen: Gosu::Image.new('images/title_screen.png'),
      game_over: Gosu::Image.new('images/game_over.png'),
      background_blue: Gosu::Image.new('images/background_blue.png'),
      background_green: Gosu::Image.new('images/background_green.png'),
      gate_next_level: Gosu::Image.load_tiles('images/gate_next_level.png', 23, 115),
      ball_cyan: Gosu::Image.new('images/ball_cyan.png'),
      ball_red: Gosu::Image.new('images/ball_red.png'),
      paddle_red_new: Gosu::Image.load_tiles('images/paddle_red_new.png', 92, 46),
      paddle_red_destroyed: Gosu::Image.new('images/paddle_red_destroyed.png'),
      paddle_red: Gosu::Image.load_tiles('images/paddle_red.png', 103, 34),
      paddle_red_wide: Gosu::Image.load_tiles('images/paddle_red_wide.png', 147, 34),
      paddle_orange_laser_new: Gosu::Image.load_tiles('images/paddle_orange_laser_gun_new.png', 32, 8),
      paddle_orange_laser: Gosu::Image.load_tiles('images/paddle_orange_laser_gun.png', 103, 32),
      laser_beam: Gosu::Image.new('images/laser_beam.png'),
      brick_gold_shine: Gosu::Image.load_tiles('images/brick_gold_shine.png', 46, 23),
      brick_silver_shine: Gosu::Image.load_tiles('images/brick_silver_shine.png', 46, 23),
      lives: Gosu::Image.new('images/life.png'),
      one_up: Gosu::Image.new('images/one_up.png'),
      press_n_to_continue: Gosu::Image.load_tiles('images/press_n_to_continue.png', 483, 23),
  }

  SOUND_EFFECTS = {
      welcome_screen: Gosu::Song.new("sounds/title_screen.mp3"),
      game_start: Gosu::Song.new("sounds/game_start.ogg"),
      game_over: Gosu::Sample.new("sounds/game_over.mp3"),
      paddle_red_new: Gosu::Sample.new("sounds/paddle.wav"),
      brick_hit: Gosu::Sample.new("sounds/brick_hit.wav"),
      brick_destroyed: Gosu::Sample.new("sounds/brick_destroyed.wav"),
      life_lost: Gosu::Sample.new("sounds/life_loose.wav")
  }

  BRICK_TYPES = {
      b: {image: Gosu::Image.new('images/brick_blue.png'), lives: 1, points: 100},
      c: {image: Gosu::Image.new('images/brick_cyan.png'), lives: 1, points: 70},
      g: {image: Gosu::Image.new('images/brick_green.png'), lives: 1, points: 80},
      o: {image: Gosu::Image.new('images/brick_orange.png'), lives: 1, points: 60},
      p: {image: Gosu::Image.new('images/brick_pink.png'), lives: 1, points: 110},
      r: {image: Gosu::Image.new('images/brick_red.png'), lives: 1, points: 90},
      w: {image: Gosu::Image.new('images/brick_white.png'), lives: 1, points: 50},
      y: {image: Gosu::Image.new('images/brick_yellow.png'), lives: 1, points: 120},
      G: {image: Gosu::Image.new('images/brick_gold.png'), lives: BRICK_LIVES_INFINITE, points: 200},
      S: {image: Gosu::Image.new('images/brick_silver.png'), lives: 2, points: 0}
  }

  POWER_TYPES = {
      b: Gosu::Image.load_tiles('images/power_b.png', POWER_WIDTH, POWER_HEIGHT),
      c: Gosu::Image.load_tiles('images/power_c.png', POWER_WIDTH, POWER_HEIGHT),
      d: Gosu::Image.load_tiles('images/power_d.png', POWER_WIDTH, POWER_HEIGHT),
      e: Gosu::Image.load_tiles('images/power_e.png', POWER_WIDTH, POWER_HEIGHT),
      l: Gosu::Image.load_tiles('images/power_l.png', POWER_WIDTH, POWER_HEIGHT),
      m: Gosu::Image.load_tiles('images/power_m.png', POWER_WIDTH, POWER_HEIGHT),
      p: Gosu::Image.load_tiles('images/power_p.png', POWER_WIDTH, POWER_HEIGHT),
  }

  NUMBER_WIDTH = NUMBER_HEIGHT = 20
  NUMBER_IMAGES = {
      '0' => Gosu::Image.new('images/zero.png'),
      '1' => Gosu::Image.new('images/one.png'),
      '2' => Gosu::Image.new('images/two.png'),
      '3' => Gosu::Image.new('images/three.png'),
      '4' => Gosu::Image.new('images/four.png'),
      '5' => Gosu::Image.new('images/five.png'),
      '6' => Gosu::Image.new('images/six.png'),
      '7' => Gosu::Image.new('images/seven.png'),
      '8' => Gosu::Image.new('images/eight.png'),
      '9' => Gosu::Image.new('images/nine.png'),
  }

  @mute = true #false

  def self.toggle_mute
    @mute = !@mute
  end

  def self.play_sound(sound)
    sound.play if !@mute
  end
end