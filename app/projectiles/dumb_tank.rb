class DumbTank < Projectile
  def initialize(x, y, dx)
    sprite_sheet = Gosu::Image.load_tiles("sprites/basic_tank.png", 24, 24, retro: true)
    super(x, y, 24, dx, 0, sprite_sheet[2 - dx])
  end
end
