class Tileset
  WIDTH = 20
  HEIGHT = 10

  def initialize(filename)
    file = File.read "maps/#{filename}"
    @map = JSON.parse file

    tileset_name = @map["tilesets"][0]["image"]
    @tiles = Gosu::Image.load_tiles("maps/#{tileset_name}", 32, 32, retro: true)
    @background = @map["layers"].find do |layer|
      layer["name"] == "BackgroundLayer"
    end["data"]
  end

  def draw
    Gosu.scale(2) do
      @background.map do |tile_index|
        @tiles[tile_index - 1]
      end.each_with_index do |tile, index|
        tile.draw (index % WIDTH) * 32, (index / WIDTH) * 32, 0
      end
    end
  end
end
