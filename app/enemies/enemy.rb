class Enemy
  attr_reader :x
  attr_reader :y
  attr_reader :size

  attr_writer :path

  def initialize(tile_coordinates, hp, size, speed, sprite_name)
    @max_hp = hp
    @hp = hp
    @size = size
    @speed = speed

    @x = tile_coordinates[0] * 32 + (32 - size) / 2
    @y = tile_coordinates[1] * 32 + (32 - size) / 2

    @sprites = Gosu::Image.load_tiles(sprite_name, size, size, retro: true)
    @healthbar = Gosu::Image.new "sprites/healthbar.png"

    @status = :moving
    @path = Game.instance.path.path

    move
  end

  def update
    if @status == :moving
      move
    end
  end

  def tile_coordinates
    [((@x + 16) / 32).floor, ((@y + 16) / 32).floor]
  end

  def occupied_coordinates
    [[@x / 32, @y / 32], [(@x + @size) / 32, (@y + @size) / 32]]
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

    if @hp < @max_hp
      healthbar_x = @x - (32 - size) / 2
      healthbar_y = @y + size
      Healthbar::draw healthbar_x, healthbar_y, @hp, @max_hp
    end
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

    if @x % 32 == (32 - @size) / 2 &&
       @y % 32 == (32 - @size) / 2 && @next_tile
      # we are in the center of the tile
      if @next_tile
        next_tile_index = @path.find_index(current_tile)
        unless next_tile_index
          # the path was blocked. find a new one.
          @path = Game.instance.path.calculate_path(current_tile)
          if @next_tile == Game.instance.level.base
            @path = []
          elsif @path.empty?
            try_tile = [current_tile[0] + 1, current_tile[1]]
            unless Game.instance.path.accessible? try_tile
              try_tile = [current_tile[0] + 1, current_tile[1]]
            end
            unless Game.instance.path.accessible? try_tile
              try_tile = [current_tile[0], current_tile[1] + 1]
            end
            unless Game.instance.path.accessible? try_tile
              try_tile = [current_tile[0] - 1, current_tile[1]]
            end
            unless Game.instance.path.accessible? try_tile
              try_tile = [current_tile[0], current_tile[1] - 1]
            end
            @path = Game.instance.path.calculate_path(try_tile)
          end
          next_tile_index = -1
        end
        next_tile_index += 1
      end
      if current_tile == Game.instance.level.base
        @status = :hit
        Game.instance.master_cookie.take_damage
        return
      end
      @next_tile = @path[next_tile_index]

      if @next_tile
        @dx = (@next_tile[0] - current_tile[0]) * @speed
        @dy = (@next_tile[1] - current_tile[1]) * @speed
      end
    elsif not @next_tile
      @next_tile = @path[0]
      if @next_tile
        @dx = (@next_tile[0] - current_tile[0]) * @speed
        @dy = (@next_tile[1] - current_tile[1]) * @speed
      end
    end

    @x += @dx
    @y += @dy

    # center the entity if we offshoot the target tile
    if @next_tile
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
end
