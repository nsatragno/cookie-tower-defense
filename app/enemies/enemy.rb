class Enemy
  attr_reader :x
  attr_reader :y
  attr_reader :size

  def initialize(tile_coordinates, hp, size, speed, sprite_name)
    @hp = hp
    @size = size
    @speed = speed

    @x = tile_coordinates[0] * 32 + (32 - size) / 2
    @y = tile_coordinates[1] * 32 + (32 - size) / 2

    @sprites = Gosu::Image.load_tiles(sprite_name, size, size, retro: true)

    @status = :moving

    move
  end

  def update
    if @status == :moving
      move
    end
  end

  def tile_coordinates
    [(@x + 16) / 32, (@y + 16) / 32]
  end

  def draw
    if @dy < 0
      sprite_index = 0
    elsif @dx > 0
      sprite_index = 1
    elsif @dy > 0
      sprite_index = 2
    else
      sprite_index = 3
    end
    if @status == :damaged
      color = 0x33_ff0000
      @status = :moving
    else
      color = 0xff_ffffff
    end
    @sprites[sprite_index].draw @x, @y, 2, 1, 1, color
  end

  def remove?
    @status == :dead or @status == :hit
  end

  def take_damage!(damage)
    @hp -= damage
    @status = @hp <= 0 ? :dead : :damaged
  end

  def hitbox
    Rect.new(@x, @y, @size, @size)
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
