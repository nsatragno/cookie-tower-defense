class Level4 < Level
  def initialize
    @tileset = Tileset.new "level4.json"
    @spawn = [2, 1]
    @base = [17, 8]

    @enemies_to_spawn = [
      { enemy: Apc, delta: 0 },

      { enemy: FastTank, delta: 3000 },
      { enemy: FastTank, delta: 240 },
      { enemy: FastTank, delta: 240 },
      { enemy: FastTank, delta: 120 },
      { enemy: FastTank, delta: 120 },
      { enemy: FastTank, delta: 120 },
      { enemy: FastTank, delta: 300 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },

      { enemy: Apc, delta: 300 },
    ]

    @allowed_buttons = [0, 1]
    super
  end

  def dough_piles
    [DoughPile.new(5, 7, 50), DoughPile.new(6, 7, 50), DoughPile.new(7, 7, 50)]
  end

  def next
    Level4.new
  end
end
