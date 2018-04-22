class Game
  attr_accessor :placing_turret
  attr_reader :map
  attr_reader :level
  attr_reader :enemies
  attr_reader :path

  include Singleton

  def initialize
    @level = Level1.new
    @spawn = [19, 1]
    @base = [0, 5]
    @path = PathFinder.new @level.map, @level.spawn, @level.base
    @toolbar = Toolbar.new
    @cursor = Cursor.new
    @turrets = []
    @enemies = []
    @bullets = []
    @font = Gosu::Font.new 20
  end

  def update
    @level.update
    new_enemy = @level.spawn_enemy
    if new_enemy
      @enemies << new_enemy
    end
    @map = @level.map

    @turrets.each do |turret|
      turret.update
      coordinates = turret.tile_coordinates
      @map[coordinates[0]][coordinates[1]] = :obstacle
    end
    @bullets.delete_if do |bullet|
      @enemies.each do |enemy|
        bullet.damage! enemy if bullet.colliding? enemy
      end
      bullet.update
      bullet.remove?
    end
    @enemies.delete_if do |enemy|
      enemy.update
      enemy.remove?
    end

    if @placing_turret
      @placing_turret.update
      new_map = dup_map
      coordinates = @placing_turret.tile_coordinates
      new_map[coordinates[0]][coordinates[1]] = :obstacle
      if @placing_turret.changed_tiles
        @new_path = PathFinder.new new_map, @level.spawn, @level.base, 0x33_0000ff
      end

      if @placing_turret.placed
        @turrets << @placing_turret
        @path = @new_path
        @enemies.each do |enemy|
          enemy.path = @path
        end
        @path.color = 0x33_00ff00
        @new_path = nil
        @placing_turret = nil
      end
    end
    @toolbar.update

  end

  def draw
    Gosu.scale(2) do
      @font.draw Gosu.fps, 0, 0, 1
      @level.draw
      @toolbar.draw
      @turrets.each &:draw
      @bullets.each &:draw
      @enemies.each &:draw

      @placing_turret&.draw
      @new_path&.draw

      @path.draw
    end
    @cursor.draw
  end

  def is_occupied?(x, y)
    return true if x < 0 or x >= Tileset::WIDTH or y < 0 or y >= Tileset::HEIGHT
    return true if @map[x][y] != :free

    return true if @enemies.find do |enemy|
      coordinates = enemy.tile_coordinates
      coordinates == [x, y]
    end

    new_map = dup_map
    new_map[x][y] = :obstacle
    @enemies.find do |enemy|
      not PathFinder.new(new_map, enemy.tile_coordinates, @level.base).valid
    end
  end

  def dup_map
    @map.map do |line| line.dup end
  end

  def add_bullet(bullet)
    @bullets << bullet
  end
end
