class Game
  def initialize
    @level = Level1.new
    @cursor = Cursor.new
  end

  def update
    @level.update
  end

  def draw
    Gosu.scale(2) do
      @level.draw
    end
    @cursor.draw
  end
end
