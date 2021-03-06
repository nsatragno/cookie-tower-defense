class ToasterTurret < Turret
  SAMPLE = Gosu::Sample.new "samples/toaster_fire.ogg"

  def initialize
    super("sprites/toaster_sheet.png", 3, 30, 15)
  end

  def fire!(dx, dy)
    Game.instance.add_bullet(Poptart.new @x + 12, @y + 10, dx, dy, @rotation)
    SAMPLE.play 0.2
  end
end
