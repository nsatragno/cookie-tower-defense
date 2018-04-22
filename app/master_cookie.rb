class MasterCookie
  attr_reader :tile_x
  attr_reader :tile_y

  def initialize(tile_x, tile_y)
    @tile_x = tile_x
    @tile_y = tile_y
    @sprite = Gosu::Image.new "sprites/big_cookie.png", retro: true
    @status = :idle
  end

  def take_damage
    @status = :damaged
  end

  def draw
    if @status == :idle
      color = 0xff_ffffff
    else
      @status = :idle
      color = 0xff_ff0000
    end
    @sprite.draw (tile_x - 1) * 32, (tile_y - 1) * 32, 1, 1, 1, color
  end
end
