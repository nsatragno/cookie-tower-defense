class Level1 < Level
  def initialize
    @tileset = Tileset.new "level1.json"
    @spawn = [19, 1]
    @base = [1, 5]

    @enemies_to_spawn = [
      { enemy: BasicEnemy, delta: 0 },
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

      { enemy: Apc, delta: 300 },
    ]

    @allowed_buttons = [0]

    @song = Gosu::Song.new "music/level_1_track.ogg"
    @song.volume = 0.2

    super
  end

  def dough_piles
    [DoughPile.new(1, 1, 50), DoughPile.new(1, 2, 50), DoughPile.new(2, 2, 50)]
  end

  def next
    Level2.new
  end
end
