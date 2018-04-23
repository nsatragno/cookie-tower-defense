class PlusOne
  LIFE = 30
  SPEED = -1

  FONT_SIZE = 10
  FONT = Gosu::Font.new FONT_SIZE, name: "fonts/dpcomic.ttf"

  def initialize(text, color, x, y)
    @text = text
    @color = color
    @x = x
    @y = y
    @timer = LIFE
  end

  def update
    @timer -= 1
    @y += SPEED
  end

  def draw
    FONT.draw @text, @x, @y + 1, 50000, 1, 1, 0xff_000000
    FONT.draw @text, @x, @y, 50000, 1, 1, @color
  end

  def remove?
    @timer <= 0
  end
end
