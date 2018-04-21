class Input
  MS_LEFT = Gosu::MS_LEFT
  MS_RIGHT = Gosu::MS_RIGHT

  LEFT = Gosu::KB_LEFT
  RIGHT = Gosu::KB_RIGHT
  UP = Gosu::KB_UP
  DOWN = Gosu::KB_DOWN
  FIRE = Gosu::KB_Z

  BUTTONS = [MS_LEFT, MS_RIGHT, LEFT, RIGHT, UP, DOWN, FIRE]

  @@pressed = {}

  def self.button_pressed?(button)
    button_down?(button) and not @@pressed[button]
  end

  def self.button_down?(button)
    case button
    when MS_LEFT
      Gosu.button_down?(Gosu::MS_LEFT)
    when MS_RIGHT
      Gosu.button_down?(Gosu::MS_RIGHT)
    when LEFT
      Gosu.button_down?(Gosu::KB_LEFT) or Gosu.button_down?(Gosu::GP_LEFT)
    when RIGHT
      Gosu.button_down?(Gosu::KB_RIGHT) or Gosu.button_down?(Gosu::GP_RIGHT)
    when UP
      Gosu.button_down?(Gosu::KB_UP) or Gosu.button_down?(Gosu::GP_UP)
    when DOWN
      Gosu.button_down?(Gosu::KB_DOWN) or Gosu.button_down?(Gosu::GP_DOWN)
    when FIRE
      Gosu.button_down?(Gosu::KB_Z) or Gosu.button_down?(Gosu::GP_0_BUTTON_0)
    else
      raise "Unknown button #{button}"
    end
  end

  def self.update
    BUTTONS.each do |button|
      @@pressed[button] = button_down? button
    end
  end
end
