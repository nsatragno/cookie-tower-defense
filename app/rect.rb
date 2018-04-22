class Rect
  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def intersects?(x, y)
    x >= @x && x <= @x + @width &&
    y >= @y && y <= @y + @height
  end

  def to_s
    "x: #{@x}, y: #{@y}, width: #{@width}, height: #{@height}"
  end
end
