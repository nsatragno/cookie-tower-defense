class Level2 < Level
  def initialize
    @tileset = Tileset.new "level2.json"
    @spawn = [10, 1]
    @base = [10, 8]

    @enemies_to_spawn = [
      { enemy: Apc, delta: 500 },
      { enemy: Apc, delta: 500 },
      { enemy: Apc, delta: 500 },

      { enemy: BasicEnemy, delta: 600 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },

      { enemy: BasicEnemy, delta: 200 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: BasicEnemy, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },
      { enemy: FastTank, delta: 20 },

      { enemy: FastTank, delta: 300 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
      { enemy: FastTank, delta: 5 },
    ]

    @allowed_buttons = [0, 1]

    @song = Gosu::Song.new "music/level_2_track.mp3"
    @song.volume = 0.2

    super
  end

  def dough_piles
    [DoughPile.new(1, 2, 50), DoughPile.new(2, 2, 50), DoughPile.new(1, 3, 50), DoughPile.new(2, 3, 50)]
  end

  def next
    Level3.new
  end
end
