class GameOverMenu
  X_OFFSET = 220
  Y_OFFSET = 100
  BUTTON_WIDTH = 200
  BUTTON_SPACING = 48

  def initialize
    @font = Gosu::Font.new 15, name: "fonts/dpcomic.ttf"

    game_over_button = TextButton.new(X_OFFSET, Y_OFFSET, "Game Over", BUTTON_WIDTH, 32, false) do
    end

    restart_button = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING, "Restart Game", BUTTON_WIDTH, 32) do
      Window.instance.screen = Menu.new
    end

    exit_button = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING * 2, "Exit Game", BUTTON_WIDTH, 32) do
      exit
    end

    @buttons = [ game_over_button, restart_button, exit_button ]
  end

  def update
    @buttons.each &:update
  end

  def draw
    Gosu.draw_rect(0, 0, Window::WINDOW_WIDTH / 2, Window::WINDOW_HEIGHT / 2, 0x66_000000, 200)
    Gosu.draw_rect(X_OFFSET, Y_OFFSET - (BUTTON_SPACING - 32) / 2, BUTTON_WIDTH, BUTTON_SPACING * 3, 0xaa_000000, 200)
    @buttons.each &:draw
  end
end
