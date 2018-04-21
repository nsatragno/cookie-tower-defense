class Level1
  attr_reader :map
  attr_reader :path

  def initialize
    @tileset = Tileset.new "level1.json"

    @map = []
    (0...Tileset::WIDTH).each do |x|
      line = []
      (0...Tileset::HEIGHT).each do |y|
        line << (@tileset.obstacles[x + y * Tileset::WIDTH] == 0 ? :free : :obstacle)
      end
      @map << line
    end

    @path = PathFinder.new @map, [19, 1], [0, 5]
  end

  def update
  end

  def draw
    @tileset.draw
    @path.draw
  end
end
