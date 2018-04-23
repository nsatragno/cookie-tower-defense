class LevelCompleteMenu
  X_OFFSET = 220
  Y_OFFSET = 100
  BUTTON_WIDTH = 200
  BUTTON_SPACING = 48

  def initialize(next_level)
    @font = Gosu::Font.new 15, name: "fonts/dpcomic.ttf"

    level_complete_button = TextButton.new(X_OFFSET, Y_OFFSET, "Level Complete!", BUTTON_WIDTH, 32, false) do
    end

    next_button = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING, "Next Level", BUTTON_WIDTH, 32) do
      Game.instance.restart!(next_level)
      Window.instance.screen = Game.instance
    end

    @buttons = [ level_complete_button, next_button ]
  end

  def update
    @buttons.each &:update
  end

  def draw
    Gosu.draw_rect(0, 0, Window::WINDOW_WIDTH / 2, Window::WINDOW_HEIGHT / 2, 0x66_000000, 100)
    Gosu.draw_rect(X_OFFSET, Y_OFFSET - (BUTTON_SPACING - 32) / 2, BUTTON_WIDTH, BUTTON_SPACING * 2, 0xaa_000000, 100)
    @buttons.each &:draw
  end
end
