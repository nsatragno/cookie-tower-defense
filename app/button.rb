class Button
  attr_reader :x
  attr_reader :y
  attr_reader :width
  attr_reader :height

  def initialize(x, y, width = 32, height = 32, &action)
    @x = x
    @y = y
    @width = width
    @height = height
    @action = action
    @status = :idle
  end

  def update
    if @x <= Window.instance.mouse_x / 2 and Window.instance.mouse_x / 2 <= @x + @width and
       @y <= Window.instance.mouse_y / 2 and Window.instance.mouse_y / 2 <= @y + @height
      if Input::button_released?(Input::MS_LEFT)
        @action.call
      elsif Input::button_down?(Input::MS_LEFT)
        @status = :clicked
      else
        @status = :hover
      end
    else
      @status = :idle
    end
  end
end
