class Projectile
  def initialize(x, y, size, dx, dy, sprite, damage = 1, x_offset = 0, y_offset = 0)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @size = size
    @sprite = sprite
    @damage = damage
    @status = :alive
    @x_offset = x_offset
    @y_offset = y_offset
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
    @sprite.draw @x + @x_offset, @y + @y_offset, 2
  end

  def colliding?(entity)
    entity.hitbox.intersects?(@x + @size / 2, @y + @size / 2, @size, @size)
  end
end
