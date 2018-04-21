class Window < Gosu::Window
  GAME_TITLE = "cookie-tower-defense"

  WINDOW_HEIGHT = 720
  WINDOW_WIDTH = 1280

  include Singleton

  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = GAME_TITLE
    @screen = Game.new
  end

  def update
    @screen.update
    Input.update
  end

  def draw
    @screen.draw
  end
end
