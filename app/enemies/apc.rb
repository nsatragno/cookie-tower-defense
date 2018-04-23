class Apc < Enemy
  def initialize(tile_coordinates)
    super(tile_coordinates, 100, 32, 0.25, "sprites/apc.png", 3)
  end
end
