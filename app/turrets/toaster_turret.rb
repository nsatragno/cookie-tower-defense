class ToasterTurret < Turret
  def initialize
    super("sprites/toaster_sheet.png", 3, 20, 15)
  end

  def fire!(dx, dy)
    Game.instance.add_bullet(Poptart.new @x + 11, @y + 2, dx, dy, @rotation)
  end
end
