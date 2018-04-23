class BasicEnemy < Enemy
  def initialize(tile_coordinates)
    super(tile_coordinates, 10, 24, 1, "sprites/basic_tank.png")
  end
end
