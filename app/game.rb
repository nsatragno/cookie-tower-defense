class Game
  attr_accessor :tutorial
  attr_accessor :dough
  attr_accessor :placing_turret
  attr_accessor :dough_piles
  attr_reader :level
  attr_reader :map
  attr_reader :enemies
  attr_reader :path
  attr_reader :master_cookie
  attr_reader :toolbar

  include Singleton

  def restart!(level)
    @level = level
    @toolbar = Toolbar.new
    @turrets = []
    @enemies = []
    @bullets = []
    @master_cookie = @level.master_cookie
    @dough_piles = @level.dough_piles
    @dough = 0
    @font = Gosu::Font.new 20
    @path = PathFinder.new build_map, @level.spawn, @level.base
    @pause = nil
  end

  def build_map
    map = @level.map.map do |line|
      line.dup
    end
    @dough_piles.each do |pile|
      map[pile.tile_x][pile.tile_y] = :obstacle
    end
    @turrets.each do |turret|
      coordinates = turret.tile_coordinates
      map[coordinates[0]][coordinates[1]] = :obstacle
    end
    map
  end

  def resume!
    @pause = nil
  end

  def update
    if @pause
      return @pause.update
    elsif Input::button_pressed? Input::ESCAPE
      return @pause = PauseMenu.new
    end

    if @tutorial
      @tutorial.update
      if @tutorial.remove?
        @tutorial = nil
      end
    end

    map_changed = false

    unless @tutorial
      @level.update
      new_enemy = @level.spawn_enemy
      if new_enemy
        @enemies << new_enemy
      end
    end
    @map = build_map

    @dough_piles.delete_if do |pile|
      pile.update
      if pile.remove?
        map_changed = true
        next true
      end
      false
    end

    @turrets.each do |turret|
      turret.update
      coordinates = turret.tile_coordinates
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
      if @placing_turret.remove?
        @placing_turret = nil
      else
        new_map = dup_map
        coordinates = @placing_turret.tile_coordinates
        new_map[coordinates[0]][coordinates[1]] = :obstacle
        if @placing_turret.changed_tiles
          @new_path = PathFinder.new new_map, @level.spawn, @level.base, 0x33_0000ff
        end

        if @placing_turret.placed
          map_changed = true
          @turrets << @placing_turret
          @new_path = nil
          @placing_turret = @placing_turret.class.new
        end
      end
    end
    @toolbar.update

    if map_changed
      @path = PathFinder.new build_map, @level.spawn, @level.base, 0x33_00ff00
      @enemies.each do |enemy|
        enemy.path = @path.path
      end
    end

    if @master_cookie.status == :dead
      @pause = GameOverMenu.new
      return
    end

    if @level.done? and @enemies.empty?
      if @level.next
        @pause = LevelCompleteMenu.new @level.next
      else
        @pause = GameCompleteMenu.new
      end
    end
  end

  def draw
    Gosu.scale(2) do
      @level.draw
      @toolbar.draw
      @turrets.each &:draw
      @bullets.each &:draw
      @enemies.each &:draw

      @placing_turret&.draw
      @dough_piles.each &:draw

      @master_cookie.draw
      @tutorial&.draw
      #@new_path&.draw
      #@path.draw
      @pause&.draw
    end
  end

  def is_occupied?(x, y)
    return true if x < 0 or x >= Tileset::WIDTH or y < 0 or y >= Tileset::HEIGHT
    return true if @map[x][y] != :free
    return true if @master_cookie.collision_tiles.find_index [x, y]

    return true if @enemies.find do |enemy|
      coordinates = enemy.occupied_coordinates
      coordinates.find_index [x, y]
    end

    new_map = dup_map
    new_map[x][y] = :obstacle
    new_path = PathFinder.new(new_map, @level.spawn, @level.base)
    return true unless new_path.valid
    @enemies.find do |enemy|
      not new_path.accessible? enemy.tile_coordinates
    end
  end

  def dup_map
    @map.map do |line| line.dup end
  end

  def add_bullet(bullet)
    @bullets << bullet
  end
end
