class DoughPile < ImageButton
  attr_reader :tile_x
  attr_reader :tile_y

  def initialize(tile_x, tile_y, dough)
    @dough = dough

    @tile_x = tile_x
    @tile_y = tile_y
    super(tile_x * 32, tile_y * 32 - 16, "sprites/dough.png", 32, 48) do
      Game.instance.dough += 1
      @dough -= 1
    end
  end

  def remove?
    @dough <= 0
  end
end
