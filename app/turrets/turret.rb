class Turret
  attr_reader :placed
  attr_reader :changed_tiles

  def initialize(sprite_name, range)
    @sprite = Gosu::Image.load_tiles(sprite_name, 32, 32)
    @placed = false
    @range = range
    @x, @y = normalize_coordinates(Window.instance.mouse_x, Window.instance.mouse_y)
    @update_new_path = true
    @color = 0x99_ff0000
    @rotation = 0
  end

  def update
    if @placed
      if @locked_on
        if @tiles_in_range.find_index @locked_on.tile_coordinates
          coordinates = tile_coordinates
          locked_on_coordinates = @locked_on.tile_coordinates
          delta_x = locked_on_coordinates[0] - coordinates[0]
          delta_y = locked_on_coordinates[1] - coordinates[1]
          if delta_x == 0 and delta_y > 0
            @rotation = 7
          elsif delta_x == 0 and delta_y < 0
            @rotation = 1
          elsif delta_x > 0 and delta_y == 0
            @rotation = 5
          elsif delta_x < 0 and delta_y == 0
            @rotation = 3
          elsif delta_x > 0 and delta_y > 0
            @rotation = 8
          elsif delta_x > 0 and delta_y < 0
            @rotation = 2
          elsif delta_x < 0 and delta_y > 0
            @rotation = 6
          elsif delta_x < 0 and delta_y < 0
            @rotation = 0
          end
        else
          @locked_on = nil
        end
      end

      unless @locked_on
        @locked_on = Game.instance.enemies.find do |enemy|
          @tiles_in_range.find_index enemy.tile_coordinates
        end
      end
    else
      old_coordinates = tile_coordinates
      @x, @y = normalize_coordinates(Window.instance.mouse_x, Window.instance.mouse_y)
      @changed_tiles = old_coordinates != tile_coordinates

      if @changed_tiles
        @tiles_in_range = tiles_in_range
        if Game.instance.is_occupied? @x / 32, @y / 32
          @color = 0x99_ff0000
        else
          @color = 0x44_ffffff
        end
      end

      if Input::button_pressed? Input::MS_LEFT
        unless Game.instance.is_occupied? @x / 32, @y / 32
          @placed = true
        end
      end
    end
  end

  def draw
    if @placed
      @sprite[@rotation].draw @x, @y, 2
    else
      @sprite[0].draw @x, @y, 10, 1, 1, @color
      @tiles_in_range&.each do |tile|
        Gosu::draw_rect(tile[0] * 32, tile[1] * 32, 32, 32, 0x33_ffffff)
      end
    end
  end

  def tile_coordinates
    [@x / 32, @y / 32]
  end

  def tiles_in_range
    coordinates = tile_coordinates

    tiles = []
    (-@range..@range).each do |x|
      (-@range..@range).each do |y|
        tiles << [x, y]
      end
    end

    tiles = tiles.select do |tile|
      tile[0].abs + tile[1].abs <= @range or
      (tile[0] == 0 and tile[1] == 0)
    end.map do |tile|
      [coordinates[0] + tile[0], coordinates[1] + tile[1]]
    end.select do |tile|
      tile[0] >= 0 and tile[0] < Tileset::WIDTH and
      tile[1] >= 0 and tile[1] < Tileset::HEIGHT
    end

    tiles
  end

  def normalize_coordinates(x, y)
    [(x / 32 / 2).floor * 32,
     (y / 32 / 2).floor * 32]
  end
end