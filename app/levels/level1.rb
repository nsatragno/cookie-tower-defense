class Level1
  def initialize
    @tileset = Tileset.new "level1.json"
  end

  def update
  end

  def draw
    @tileset.draw
  end
end
