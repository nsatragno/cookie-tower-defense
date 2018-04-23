class FastTank < Enemy
  def initialize(tile_coordinates)
    super(tile_coordinates, 15, 24, 2, "sprites/fast_tank.png")
  end
end
