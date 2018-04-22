class Tileset
  WIDTH = 20
  HEIGHT = 10

  attr_reader :obstacles

  def initialize(filename)
    file = File.read "maps/#{filename}"
    @map = JSON.parse file

    tileset_name = @map["tilesets"][0]["image"]
    @tiles = Gosu::Image.load_tiles("maps/#{tileset_name}", 32, 32, retro: true)
    @layers = @map["layers"]
    @obstacles = @layers.find do |layer|
      layer["name"] == "ObstacleLayer"
    end["data"]
    @layers.reject! do |layer|
      layer["name"] == "ObstacleLayer"
    end
  end

  def draw
    @layers.each do |layer|
      draw_layer layer["data"]
    end
  end

  private
  def draw_layer(layer)
    layer.map do |tile_index|
      tile_index == 0 ? nil : @tiles[tile_index - 1]
    end.each_with_index do |tile, index|
      next unless tile
      tile.draw (index % WIDTH) * 32, (index / WIDTH) * 32, 0
    end
  end
end
