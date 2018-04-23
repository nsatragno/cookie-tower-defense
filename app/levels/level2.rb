class Level2 < Level
  def initialize
    @tileset = Tileset.new "level1.json"
    @spawn = [19, 2]
    @base = [1, 5]

    @enemies_to_spawn = [
      { enemy: FastTank, delta: 0 },
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

    @allowed_buttons = [0]
    super
  end

  def dough_piles
    [DoughPile.new(1, 1, 10), DoughPile.new(1, 2, 10), DoughPile.new(2, 2, 10)]
  end

  def next
    Level2.new
  end
end
