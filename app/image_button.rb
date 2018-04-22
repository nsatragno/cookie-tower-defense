class ImageButton < Button
  def initialize(x, y, sprite_name, width = 32, height = 32, &action)
    @sprite = Gosu::Image.new sprite_name, retro: true
    super x, y, width, height do
      action.call
    end
  end

  def draw
    @sprite.draw @x, @y, 1
    if @status == :hover
      Gosu::draw_rect(@x, @y, @width, @height, 0x20_ffffff, 1)
    elsif @status == :clicked
      Gosu::draw_rect(@x, @y, @width, @height, 0x80_00ffff, 1)
    end
  end
end
