class CookieShooterTurret < Turret
  def initialize
    super("sprites/cookie_shooter_sheet.png", 2, 20, 10)
  end

  def fire!(dx, dy)
    Game.instance.add_bullet(Cookie.new @x + 11, @y + 2, dx, dy)
  end
end
