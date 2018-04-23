class BasicTurret < Turret
  def initialize
    super("sprites/basic_turret_sheet.png", 1, 10, 20)
  end

  def fire!(dx, dy)
    Game.instance.add_bullet(Cream.new @x + 12, @y + 6, dx, dy, @rotation)
  end
end
