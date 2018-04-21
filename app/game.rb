class Game
  def initialize
    @level = Level1.new
    @toolbar = Toolbar.new
    @cursor = Cursor.new
  end

  def update
    @level.update
    @toolbar.update
  end

  def draw
    Gosu.scale(2) do
      @level.draw
      @toolbar.draw
    end
    @cursor.draw
  end
end
