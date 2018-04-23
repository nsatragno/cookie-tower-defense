class Level1
  ENEMY_SPAWN_TIME = 120

  attr_reader :map
  attr_reader :path
  attr_reader :spawn
  attr_reader :base

  def initialize
    @timer = 0
    @tileset = Tileset.new "level1.json"
    @spawn = [19, 2]
    @base = [1, 5]

    @map = []
    (0...Tileset::WIDTH).each do |x|
      line = []
      (0...Tileset::HEIGHT).each do |y|
        line << (@tileset.obstacles[x + y * Tileset::WIDTH] == 0 ? :free : :obstacle)
      end
      @map << line
    end

  end

  def dough_piles
    [DoughPile.new(1, 1, 10), DoughPile.new(1, 2, 10), DoughPile.new(2, 2, 10)]
  end

  def master_cookie
    MasterCookie.new(*@base)
  end

  def spawn_enemy
    if @timer == 1
    #if @timer % ENEMY_SPAWN_TIME == 0
      Apc.new(@spawn)
    end
  end

  def update
    @timer += 1
  end

  def draw
    @tileset.draw
  end
end
