class Cursor
  def initialize
    @sprite = Gosu::Image.new "sprites/cursor.png"
  end

  def draw
    @sprite.draw((Window.instance.mouse_x / 2).round * 2, (Window.instance.mouse_y / 2).round * 2, 1000)
  end
end
