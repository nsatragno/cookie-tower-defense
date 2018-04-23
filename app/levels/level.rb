class Level
  ENEMY_SPAWN_TIME = 120

  attr_reader :map
  attr_reader :path
  attr_reader :spawn
  attr_reader :base

  def initialize
    @timer = 0

    @map = []
    (0...Tileset::WIDTH).each do |x|
      line = []
      (0...Tileset::HEIGHT).each do |y|
        line << (@tileset.obstacles[x + y * Tileset::WIDTH] == 0 ? :free : :obstacle)
      end
      @map << line
    end
  end

  def master_cookie
    MasterCookie.new(*@base)
  end

  def spawn_enemy
    return if @enemies_to_spawn.empty?
    if @timer >= @enemies_to_spawn[0][:delta]
      @timer = 0
      @enemies_to_spawn.shift[:enemy].new(@spawn)
    end
  end

  def update
    @timer += 1
  end

  def draw
    @tileset.draw
  end
end
