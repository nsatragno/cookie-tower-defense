class Menu
  X_OFFSET = 220
  Y_OFFSET = 60
  BUTTON_WIDTH = 200
  BUTTON_SPACING = 48

  SPAWN_PERIOD = 3
  TANK_SPAWN_PERIOD = 60

  def initialize
    @font = Gosu::Font.new 15, name: "fonts/dpcomic.ttf"
    @fullscreen = false
    song = Gosu::Song.new "music/menu_track.ogg"
    song.volume = 0.2
    song.play(true)

    title = TextButton.new(X_OFFSET, Y_OFFSET, "Cookie Tower Defense", BUTTON_WIDTH, 32, false) do
    end

    start_game = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING, "Start New Game", BUTTON_WIDTH, 32) do
      Window.instance.screen = Game.instance
      Game.instance.restart!(Level1.new)
    end

    toggle_fullscreen = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING * 2, "Toggle Fullscreen [off]", BUTTON_WIDTH, 32) do
      @fullscreen = !@fullscreen
      Window.instance.fullscreen = @fullscreen
      toggle_fullscreen.text = "Toggle Fullscreen [#{@fullscreen ? 'on' : 'off'}]"
    end

    toggle_tutorial = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING * 3, "Toggle Tutorial [on]", BUTTON_WIDTH, 32) do
      Game.instance.tutorial = Game.instance.tutorial ? nil : Tutorial.new
      toggle_tutorial.text = "Toggle Tutorial [#{Game.instance.tutorial ? 'on' : 'off'}]"
    end

    exit_game = TextButton.new(X_OFFSET, Y_OFFSET + BUTTON_SPACING * 4, "Exit Game", BUTTON_WIDTH, 32) do
      exit
    end
    @buttons = [ title, start_game, toggle_fullscreen, toggle_tutorial, exit_game ]
    @entities = []
    @tank_cooldown = 0
  end

  def update
    @buttons.each &:update

    if rand(SPAWN_PERIOD) == 0
      x = rand(X_OFFSET)
      speed = rand(3) + 1
      @entities << Cookie.new(x, 0, 0, 1, 1000, speed)
      @entities << Cookie.new(Window::WINDOW_WIDTH / 2 - x, 0, 0, 1, 1000, speed)
    end

    @tank_cooldown -= 1 if @tank_cooldown >= 0
    if rand(TANK_SPAWN_PERIOD) == 0 and @tank_cooldown <= 0
      @tank_cooldown = TANK_SPAWN_PERIOD
      x = rand(2)
      @entities << DumbTank.new(x * Window::WINDOW_WIDTH / 2,
                                Window::WINDOW_HEIGHT / 2 - 32 - 32 * x,
                                x == 0 ? 1 : -1)
    end

    @entities.delete_if do |entity|
      entity.update
      entity.remove?
    end
  end

  def draw
    Gosu.scale(2) do
      @entities.each &:draw
      @buttons.each &:draw
    end
  end
end
