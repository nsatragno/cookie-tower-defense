class CookieShooterTurret < Turret
  BULLET_COOLDOWN = 10
  def initialize
    @cooldown = 0
    super("sprites/cookie_shooter_sheet.png", 2)
  end

  def update
    @cooldown -= 1 if @cooldown > 0
    super
  end

  def maybe_fire
    return if @cooldown > 0

    @cooldown = BULLET_COOLDOWN
    case @rotation
    when 0
      dx, dy = -1, -1
    when 1
      dx, dy = 0, -1
    when 2
      dx, dy = 1, -1
    when 3
      dx, dy = -1, 0
    when 5
      dx, dy = 1, 0
    when 6
      dx, dy = -1, 1
    when 7
      dx, dy = 0, 1
    when 8
      dx, dy = 1, 1
    else
      raise "Unexpected rotation value #{@rotation}"
    end
    Game.instance.add_bullet(Cookie.new @x + 11, @y + 2, dx, dy)
  end
end
