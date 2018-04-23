class Window < Gosu::Window
  GAME_TITLE = "They Came For The Chips!"

  WINDOW_HEIGHT = 720
  WINDOW_WIDTH = 1280

  include Singleton

  attr_writer :screen

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = GAME_TITLE
    @screen = Menu.new
    @cursor = Cursor.new
  end

  def update
    @screen.update
    @cursor.update
    Input.update
  end

  def draw
    @screen.draw
    @cursor.draw
  end
end
