class MasterCookie
  attr_reader :tile_x
  attr_reader :tile_y
  attr_reader :collision_tiles
  attr_reader :status

  HP = 10

  def initialize(tile_x, tile_y)
    @tile_x = tile_x
    @tile_y = tile_y
    @sprites = Gosu::Image.load_tiles "sprites/big_cookie.png", 96, 96, retro: true
    @status = :idle
    @collision_tiles = [
      [tile_x - 1, tile_y],
      [tile_x, tile_y],
      [tile_x + 1, tile_y],
    ]
    @hp = HP
  end

  def take_damage(damage)
    @status = :damaged
    @hp -= damage
    if @hp <= 0
      @status = :dead
    end
  end

  def draw
    if @status == :idle
      color = 0xff_ffffff
    elsif @status == :damaged
      @status = :idle
      color = 0xff_ff0000
    else
      color = 0xff_ff0000
    end

    if @status == :idle
      @sprites[[(10 - @hp) / 2, 3].min].draw (tile_x - 1) * 32, (tile_y - 1) * 32, 1, 1, 1, color
    else
      @sprites[4].draw (tile_x - 1) * 32, (tile_y - 1) * 32, 1, 1, 1, color
    end

    if @hp < HP
      healthbar_x = (@tile_x) * 32
      healthbar_y = (@tile_y + 1) * 32
      Healthbar::draw healthbar_x, healthbar_y, @hp, HP
    end
  end
end
