class Cookie < Projectile
  SPEED = 3
  LIFETIME = 32 * 2.5 / SPEED

  def initialize(x, y, dx, dy)
    dx, dy = (Vector[dx, dy].normalize * SPEED).to_a
    @life = LIFETIME
    super(x, y, 10, dx, dy, Gosu::Image.new("sprites/small_cookie.png", retro: true))
  end

  def update
    super
    @life -= 1
    @status = :dead if @life <= 0
  end
end
