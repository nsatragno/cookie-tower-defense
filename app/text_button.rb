class TextButton < Button
  FONT_SIZE = 15

  SHEET = Gosu::Image.load_tiles "sprites/text_button_sheet.png", 200, 32, retro: true

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

    if @enabled
      if @status == :hover
        SHEET[1].draw @x, @y, 200
      elsif @status == :clicked
        SHEET[2].draw @x, @y, 200
      else
        SHEET[0].draw @x, @y, 200
      end
    end

    @font.draw @text, @x + (@width - text_width) / 2, @y + FONT_SIZE / 2, 200
  end
end
