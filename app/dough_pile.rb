class DoughPile < Button
  def initialize(tile_x, tile_y, dough)
    @dough = dough

    super(tile_x * 32, tile_y * 32, "sprites/cookie_shooter_icon.png") do
      Game.instance.dough += 1
      @dough -= 1
    end
  end

  def remove?
    @dough <= 0
  end
end
