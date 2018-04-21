class Toolbar
  Y_OFFSET = 10 * 32
  HEIGHT = 40

  def initialize
    basic_turret_button = Button.new 0, Y_OFFSET, "sprites/basic_turret_icon.png" do
      Game.instance.placing_turret = BasicTurret.new
    end

    @buttons = [basic_turret_button]
  end

  def update
    @buttons.each &:update
  end

  def draw
    @buttons.each &:draw
  end
end
