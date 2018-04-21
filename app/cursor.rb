class Cursor
  def initialize
    @sprite = Gosu::Image.new "sprites/cursor.png"
  end

  def draw
    @sprite.draw(Window.instance.mouse_x, Window.instance.mouse_y, 1000)
  end
end
