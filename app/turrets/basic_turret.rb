class BasicTurret < Turret
  def initialize
    super("sprites/basic_turret_sheet.png", 1, 10, 20)
  end

  def fire!(dx, dy)
    Game.instance.add_bullet(Cream.new @x, @y - 5, dx, dy, @rotation)
  end
end
