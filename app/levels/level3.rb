class Level3 < Level
  TOTAL_ENEMIES = 100

  def initialize
    @tileset = Tileset.new "level3.json"
    @spawn = [19, 2]
    @base = [1, 5]

    @enemies_to_spawn = []
    @enemies_to_spawn = (0...TOTAL_ENEMIES).map do |i|
      enemy_random = rand(20)
      if enemy_random == 0
        enemy = Apc
      elsif enemy_random < 3 + i / 20
        enemy = FastTank
      else
        enemy = BasicEnemy
      end
      delta = rand(40) + 10 + (20 - i % 20) * 3
      if i % 20 == 0
        delta += 500
      end
      { enemy: enemy, delta: delta }
    end

    @allowed_buttons = [0, 1, 2, 3]
    super
  end

  def dough_piles
    [DoughPile.new(1, 2, 50), DoughPile.new(2, 2, 50), DoughPile.new(1, 3, 50), DoughPile.new(2, 3, 50)]
  end

  def next
    Level4.new
  end
end
