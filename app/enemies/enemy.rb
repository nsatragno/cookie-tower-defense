class Enemy
  def initialize(tile_coordinates, hp, size, speed, sprite_name)
    @hp = hp
    @size = size
    @speed = speed

    @x = tile_coordinates[0] * 32 + (32 - size) / 2
    @y = tile_coordinates[1] * 32 + (32 - size) / 2

    @status = :moving

    move
  end

  def update
    if @status == :moving
      move
    end
  end

  def tile_coordinates
    [@x / 32, @y / 32]
  end

  def draw
    Gosu::draw_rect(@x, @y, @size, @size, 0x88_990000)
  end

  def remove?
    @status == :dead or @status == :hit
  end

  private
  def move
    current_tile = tile_coordinates

    if @x % 32 == (32 - @size) / 2 and
       @y % 32 == (32 - @size) / 2
      # we are in the center of the tile
      next_tile_index = (Game.instance.path.path.find_index(current_tile) || -1) + 1
      if next_tile_index == Game.instance.path.path.size
        @status = :hit
        return
      end
      @next_tile = Game.instance.path.path[next_tile_index]

      @dx = (@next_tile[0] - current_tile[0]) * @speed
      @dy = (@next_tile[1] - current_tile[1]) * @speed
    end

    @x += @dx
    @y += @dy

    # center the entity if we offshoot the target tile
    if @dx > 0
      @x = [@x, @next_tile[0] * 32 + (32 - @size) / 2].min
    elsif @dx < 0
      @x = [@x, @next_tile[0] * 32 + (32 - @size) / 2].max
    elsif @dy > 0
      @y = [@y, @next_tile[1] * 32 + (32 - @size) / 2].min
    elsif @dy < 0
      @y = [@y, @next_tile[1] * 32 + (32 - @size) / 2].max
    end
  end
end
