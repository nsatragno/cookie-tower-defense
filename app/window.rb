class Window < Gosu::Window
  GAME_TITLE = "cookie-tower-defense"

  WINDOW_HEIGHT = 720
  WINDOW_WIDTH = 1280

  include Singleton

  attr_writer :screen

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = GAME_TITLE
    @screen = Menu.new
    @cursor = Cursor.new
    @font = Gosu::Font.new 15, name: "fonts/dpcomic.ttf"
  end

  def update
    @screen.update
    Input.update
  end

  def draw
    @screen.draw
    @cursor.draw
    @font.draw Gosu.fps, 0, 0, 1
  end
end
