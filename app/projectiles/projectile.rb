class Projectile
  def initialize(x, y, size, dx, dy, sprite_name)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
    @size = size
    @sprite = Gosu::Image.new sprite_name
  end

  def update
    @x += @dx
    @y += @dy
  end

  def remove?
    @x < 0 or @x >= Window::WIDTH or
    @y < 0 or @y >= Window::HEIGHT
  end

  def draw
    @sprite.draw @x, @y, @size, @size, 2
  end
end
