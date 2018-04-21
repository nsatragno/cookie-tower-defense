class Tileset
  WIDTH = 20
  HEIGHT = 10

  attr_reader :obstacles

  def initialize(filename)
    file = File.read "maps/#{filename}"
    @map = JSON.parse file

    tileset_name = @map["tilesets"][0]["image"]
    @tiles = Gosu::Image.load_tiles("maps/#{tileset_name}", 32, 32, retro: true)
    @background = @map["layers"].find do |layer|
      layer["name"] == "BackgroundLayer"
    end["data"]
    @obstacles = @map["layers"].find do |layer|
      layer["name"] == "ObstacleLayer"
    end["data"]
  end

  def draw
    draw_layer @background
    draw_layer @obstacles
  end

  private
  def draw_layer(layer)
    layer.map do |tile_index|
      @tiles[tile_index - 1]
    end.each_with_index do |tile, index|
      tile.draw (index % WIDTH) * 32, (index / WIDTH) * 32, 0
    end
  end
end
