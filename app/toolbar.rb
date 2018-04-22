class Toolbar
  Y_OFFSET = 10 * 32
  BUTTON_MARGIN = 2
  BUTTON_SPACING = 25
  HEIGHT = 40

  def initialize
    @font = Gosu::Font.new 15, name: "fonts/dpcomic.ttf"
    @sprite = Gosu::Image.new "sprites/iconbar.png", retro: true
    basic_turret_button = ImageButton.new BUTTON_MARGIN, Y_OFFSET + BUTTON_MARGIN, "sprites/basic_turret_icon.png", 24, 24 do
      Game.instance.placing_turret = BasicTurret.new
    end

    cookie_shooter_button = ImageButton.new BUTTON_MARGIN + BUTTON_SPACING, Y_OFFSET + BUTTON_MARGIN, "sprites/cookie_shooter_icon.png", 24, 24 do
      Game.instance.placing_turret = CookieShooterTurret.new
    end

    @buttons = [basic_turret_button, cookie_shooter_button]
  end

  def update
    @buttons.each &:update
  end

  def draw
    @sprite.draw 0, Y_OFFSET, 1
    @buttons.each &:draw
    @font.draw "Dough: #{Game.instance.dough}", 200, Y_OFFSET + 12, 1
  end
end
