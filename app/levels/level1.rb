class Level1 < Level
  def initialize
    @tileset = Tileset.new "level1.json"
    @spawn = [19, 2]
    @base = [1, 5]

    @enemies_to_spawn = [
      { enemy: BasicEnemy, delta: 240 },
      { enemy: BasicEnemy, delta: 240 },
      { enemy: BasicEnemy, delta: 240 },
      { enemy: BasicEnemy, delta: 120 },
      { enemy: BasicEnemy, delta: 120 },
      { enemy: BasicEnemy, delta: 120 },
      { enemy: BasicEnemy, delta: 300 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
    ]

    @allowed_buttons = [0]
    super
  end

  def dough_piles
    [DoughPile.new(1, 1, 10), DoughPile.new(1, 2, 10), DoughPile.new(2, 2, 10)]
  end
end
