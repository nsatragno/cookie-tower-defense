class Game
  def initialize
    @level = Level1.new
  end

  def update
    @level.update
  end

  def draw
    @level.draw
  end
end
