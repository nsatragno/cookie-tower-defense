class BasicEnemy < Enemy
  def initialize(tile_coordinates)
    super(tile_coordinates, 10, 24, 3, "sprites/basic_tank.png")
  end
end
