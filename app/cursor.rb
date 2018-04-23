class Cursor
  CLICK_SAMPLE = Gosu::Sample.new "samples/mouse_click.ogg"
  RELEASE_SAMPLE = Gosu::Sample.new "samples/mouse_release.ogg"

  def initialize
    @sprite = Gosu::Image.new "sprites/cursor.png"
  end

  def update
    if Input::button_pressed? Input::MS_LEFT or Input::button_pressed? Input::MS_RIGHT
      CLICK_SAMPLE.play
    elsif Input::button_released? Input::MS_LEFT or Input::button_released? Input::MS_RIGHT
      RELEASE_SAMPLE.play
    end
  end

  def draw
    @sprite.draw((Window.instance.mouse_x / 2).round * 2, (Window.instance.mouse_y / 2).round * 2, 1000)
  end
end
