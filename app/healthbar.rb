class Healthbar
  SPRITE = Gosu::Image.new "sprites/healthbar.png", retro: true
  def self.draw(x, y, hp, max_hp)
    SPRITE.draw x, y, 2

    hp_size = [26 * hp / max_hp, 0].max
    hue = 125 * hp / max_hp
    color = Gosu::Color.from_hsv(hue, 1, 1)
    Gosu::draw_rect x + 3, y + 5, hp_size, 4, color, 3
  end
end
