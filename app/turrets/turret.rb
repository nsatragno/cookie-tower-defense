class Turret
  attr_reader :placed

  def initialize(sprite_name)
    @sprite = Gosu::Image.load_tiles(sprite_name, 32, 32)
    @placed = false
  end

  def update
    if @placed
    else
      if Input::button_pressed? Input::MS_LEFT
        x, y = normalize_coordinates
        unless Game.instance.is_occupied? x / 32, y / 32
          @placed = true
          @x, @y = x, y
        end
      end
    end
  end

  def draw
    if @placed
      @sprite[0].draw @x, @y, 2
    else
      x, y = normalize_coordinates
      if Game.instance.is_occupied? x / 32, y / 32
        color = 0x99_ff0000
      else
        color = 0x44_ffffff
      end
      @sprite[0].draw x, y, 10, 1, 1, color
    end
  end

  def normalize_coordinates
    [(Window.instance.mouse_x / 32 / 2).floor * 32,
     (Window.instance.mouse_y / 32 / 2).floor * 32]
  end
end
