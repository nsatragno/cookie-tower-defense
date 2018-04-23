class Level4 < Level
  def initialize
    @tileset = Tileset.new "level4.json"
    @spawn = [2, 1]
    @base = [17, 8]

    @enemies_to_spawn = [
      { enemy: BasicEnemy, delta: 60 },
      { enemy: BasicEnemy, delta: 60 },
      { enemy: BasicEnemy, delta: 60 },
      { enemy: BasicEnemy, delta: 60 },
      { enemy: BasicEnemy, delta: 60 },
      { enemy: BasicEnemy, delta: 60 },

      { enemy: FastTank, delta: 120 },
      { enemy: FastTank, delta: 60 },
      { enemy: FastTank, delta: 60 },
      { enemy: FastTank, delta: 60 },
      { enemy: FastTank, delta: 60 },
      { enemy: FastTank, delta: 60 },

      { enemy: Apc, delta: 120 },
      { enemy: FastTank, delta: 0 },
      { enemy: FastTank, delta: 20 },
      { enemy: Apc, delta: 60 },
      { enemy: Apc, delta: 60 },
      { enemy: FastTank, delta: 0 },
      { enemy: Apc, delta: 60 },
      { enemy: Apc, delta: 60 },
      { enemy: FastTank, delta: 0 },
      { enemy: Apc, delta: 60 },
      { enemy: Apc, delta: 120 },
      { enemy: FastTank, delta: 0 },
      { enemy: FastTank, delta: 20 },
      { enemy: Apc, delta: 60 },
      { enemy: Apc, delta: 60 },
      { enemy: FastTank, delta: 0 },
      { enemy: Apc, delta: 60 },
      { enemy: Apc, delta: 60 },
      { enemy: FastTank, delta: 0 },
      { enemy: Apc, delta: 60 },
    ]

    @allowed_buttons = [0, 1, 2, 3, 4]
    super
  end

  def dough_piles
    [
      DoughPile.new(5, 7, 50),
      DoughPile.new(6, 7, 50),
      DoughPile.new(7, 7, 50),
      DoughPile.new(6, 2, 50),
      DoughPile.new(6, 3, 50),
    ]
  end

  def next
    nil
  end
end
