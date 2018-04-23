class ImageButton < Button
  def initialize(x, y, sprite_name, width = 32, height = 32, y_offset = 0, &action)
    @sprite = Gosu::Image.new sprite_name, retro: true
    @y_offset = y_offset
    super x, y, width, height do
      action.call
    end
  end

  def draw
    @sprite.draw @x, @y + @y_offset, 200
    if @status == :hover
      Gosu::draw_rect(@x, @y, @width, @height, 0x20_ffffff, 200)
    elsif @status == :clicked
      Gosu::draw_rect(@x, @y, @width, @height, 0x80_00ffff, 200)
    end
  end
end
