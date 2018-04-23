class Level2 < Level
  def initialize
    @tileset = Tileset.new "level2.json"
    @spawn = [10, 1]
    @base = [10, 8]

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

    @allowed_buttons = [0, 1, 2]
    super
  end

  def dough_piles
    [DoughPile.new(1, 2, 50), DoughPile.new(2, 2, 50), DoughPile.new(1, 3, 50), DoughPile.new(2, 3, 50)]
  end

  def next
    Level2.new
  end
end
