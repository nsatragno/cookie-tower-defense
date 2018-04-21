class Game
  attr_accessor :placing_turret
  attr_reader :map

  include Singleton

  def initialize
    @level = Level1.new
    @toolbar = Toolbar.new
    @cursor = Cursor.new
    @turrets = []
  end

  def update
    @level.update
    @map = @level.map

    @turrets.each &:update
    if @placing_turret
      @placing_turret.update
      if @placing_turret.placed
        @turrets << @placing_turret
        @placing_turret = nil
      end
    end
    @toolbar.update

  end

  def draw
    Gosu.scale(2) do
      @level.draw
      @toolbar.draw
      @turrets.each &:draw
      @placing_turret&.draw
    end
    @cursor.draw
  end

  def is_occupied?(x, y)
    return true if x < 0 or x >= Tileset::WIDTH or y < 0 or y >= Tileset::HEIGHT
    @map[x][y] != :free
  end
end
