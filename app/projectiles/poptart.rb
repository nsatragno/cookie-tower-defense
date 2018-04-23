class Poptart < Projectile
  SPEED = 4
  LIFETIME = 32 * 3.5 / SPEED
  SPRITE_SHEET = Gosu::Image.load_tiles("sprites/poptart.png", 32, 32, retro: true)

  def initialize(x, y, dx, dy, direction)
    dx, dy = (Vector[dx, dy].normalize * SPEED).to_a
    @life = LIFETIME
    sprite = SPRITE_SHEET[direction]
    super(x, y, 10, dx, dy, sprite)
  end

  def update
    super
    @life -= 1
    @status = :dead if @life <= 0
  end
end
