class Button
  SIZE = 32
  def initialize(x, y, sprite_name, &action)
    @x = x
    @y = y
    @sprite = Gosu::Image.new sprite_name, retro: true
    @action = action
    @status = :idle
  end

  def update
    if @x <= Window.instance.mouse_x / 2 and Window.instance.mouse_x / 2 <= @x + SIZE and
       @y <= Window.instance.mouse_y / 2 and Window.instance.mouse_y / 2 <= @y + SIZE
      if Input::button_pressed?(Input::MS_LEFT)
        @action.call
        @status = :clicked
      else
        @status = :hover
      end
    else
      @status = :idle
    end
  end

  def draw
    @sprite.draw @x, @y, 1
    if @status == :hover
      Gosu::draw_rect(@x, @y, SIZE, SIZE, 0x20_ffffff, 1)
    elsif @status == :clicked
      Gosu::draw_rect(@x, @y, SIZE, SIZE, 0x80_00ffff, 1)
    end
  end
end
