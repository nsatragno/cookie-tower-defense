class Toolbar
  Y_OFFSET = 10 * 32
  BUTTON_MARGIN = 8
  BUTTON_SPACING = 25
  HEIGHT = 40

  BLINK_TIMER = 10

  attr_reader :buttons
  attr_accessor :blink_dough

  def initialize
    @font = Gosu::Font.new 15, name: "fonts/dpcomic.ttf"
    @sprite = Gosu::Image.new "sprites/iconbar.png", retro: true
    basic_turret_button = ImageButton.new BUTTON_MARGIN, Y_OFFSET + BUTTON_MARGIN, "sprites/basic_turret_icon.png", 24, 24 do
      Game.instance.placing_turret = BasicTurret.new
    end

    cookie_shooter_button = ImageButton.new BUTTON_MARGIN + BUTTON_SPACING, Y_OFFSET + BUTTON_MARGIN, "sprites/cookie_shooter_icon.png", 24, 24 do
      Game.instance.placing_turret = CookieShooterTurret.new
    end

    toaster_button = ImageButton.new BUTTON_MARGIN + BUTTON_SPACING * 2, Y_OFFSET + BUTTON_MARGIN, "sprites/toaster_icon.png", 24, 24 do
      Game.instance.placing_turret = ToasterTurret.new
    end

    @buttons = [basic_turret_button, cookie_shooter_button, toaster_button]
    @timer = 0
  end

  def update
    @buttons.each_with_index do |button, index|
      next unless Game.instance.level.allowed_buttons.find_index index
      button.update
    end
    @timer += 1
  end

  def draw
    @sprite.draw 0, Y_OFFSET, 50
    @buttons.each_with_index do |button, index|
      next unless Game.instance.level.allowed_buttons.find_index index
      button.draw
    end
    if @blink_dough
      if (@timer / BLINK_TIMER) % 2 == 0
        color = 0xff_ffffff
      else
        color = 0xff_ff0000
      end
    else
      color = 0xff_ffffff
    end
    @font.draw "Dough: #{Game.instance.dough}", 200, Y_OFFSET + 12, 50, 1, 1, color
  end
end
