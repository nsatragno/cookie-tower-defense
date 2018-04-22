class Projectile
  def initialize(x, y, size, dx, dy, sprite, damage = 1)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @size = size
    @sprite = sprite
    @damage = damage
    @status = :alive
  end

  def update
    @x += @dx
    @y += @dy
  end

  def remove?
    @x < 0 || @x >= Window::WINDOW_WIDTH ||
    @y < 0 || @y >= Window::WINDOW_HEIGHT ||
    @status != :alive
  end

  def damage!(enemy)
    enemy.take_damage!(@damage)
    @status = :hit
  end

  def draw
    @sprite.draw @x, @y, 2
  end

  def colliding?(entity)
    entity.hitbox.intersects?(@x + @size / 2, @y + @size / 2)
  end
end
