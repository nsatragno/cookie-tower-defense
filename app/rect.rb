class Rect
  attr_reader :x
  attr_reader :y
  attr_reader :width
  attr_reader :height

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def intersects?(x, y, width, height)
    @x <= x + width and @x + @width >= x and
    @y + @height >= y and @y <= y + height
  end

  def to_s
    "x: #{@x}, y: #{@y}, width: #{@width}, height: #{@height}"
  end
end
