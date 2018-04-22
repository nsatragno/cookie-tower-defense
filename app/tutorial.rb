class Tutorial
  def update
    unless @steps
      first_dough_pile = Game.instance.dough_piles[0]

      dough_clicks = 10
      dough_helper = ImageButton.new(
        first_dough_pile.tile_x * 32,
        first_dough_pile.tile_y * 32 - 16,
        "sprites/click_me.png",
        32, 48) do
          dough_clicks -= 1
          if dough_clicks <= 0
            next_step
          end
        end

      turret_helper = ImageButton.new(
        Game.instance.toolbar.buttons[0].x,
        Game.instance.toolbar.buttons[0].y,
        "sprites/click_me.png",
        Game.instance.toolbar.buttons[0].width,
        Game.instance.toolbar.buttons[0].height, -10) do
          next_step
        end

      place_helper = ImageButton.new(
        32 * 16,
        32 * 7,
        "sprites/click_me.png",
        32, 32) do
          next_step
        end

      @steps = [ dough_helper, turret_helper, place_helper ]
    end

    @steps[0].update
  end

  def draw
    @steps[0].draw if @steps
  end

  def remove?
    @steps.empty?
  end

  def next_step
    @steps.shift
  end
end
