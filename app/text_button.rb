class TextButton < Button
  FONT_SIZE = 15

  attr_writer :text

  def initialize(x, y, text, width = 32, height = 32, enabled = true, &action)
    @text = text
    @enabled = enabled
    @font = Gosu::Font.new FONT_SIZE, name: "fonts/dpcomic.ttf"
    super x, y, width, height do
      action.call
    end
  end

  def draw
    text_width = @font.text_width @text
    @font.draw @text, @x + (@width - text_width) / 2, @y + FONT_SIZE / 2, 200

    if @enabled
      if @status == :hover
        Gosu::draw_rect(@x, @y, @width, @height, 0x20_ffffff, 200)
      elsif @status == :clicked
        Gosu::draw_rect(@x, @y, @width, @height, 0x80_00ffff, 200)
      end
    end
  end
end
