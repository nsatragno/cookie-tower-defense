class PathFinder
  attr_reader :valid

  def initialize(map, source, dest)
    @source = source
    @dest = dest

    @unvisited = []
    dist = []
    (0..Tileset::WIDTH).each do |i|
      line = []
      (0..Tileset::HEIGHT).each do |j|
        line << Float::INFINITY
        @unvisited << [i, j]
      end
      dist << line
    end

    prev = dist.map do |line|
      line.map do |j|
        nil
      end
    end

    dist[source[0]][source[1]] = 0

    while not @unvisited.empty?
      # find node with the least distance
      node = @unvisited[0]
      @unvisited.each do |unvisited|
        if dist[unvisited[0]][unvisited[1]] < dist[node[0]][node[1]]
          node = unvisited
        end
      end

      @unvisited.delete node

      neighbours = []
      neighbours << [node[0] - 1, node[1]]
      neighbours << [node[0] + 1, node[1]]
      neighbours << [node[0], node[1] - 1]
      neighbours << [node[0], node[1] + 1]

      neighbours.delete_if do |neighbour|
        neighbour[0] < 0 or neighbour[0] >= Tileset::WIDTH or
        neighbour[1] < 0 or neighbour[1] >= Tileset::HEIGHT or
        map[neighbour[0]][neighbour[1]] != :free
      end

      neighbours.each do |neighbour|
        distance = dist[node[0]][node[1]] + 1
        if distance < dist[neighbour[0]][neighbour[1]]
          dist[neighbour[0]][neighbour[1]] = distance
          prev[neighbour[0]][neighbour[1]] = node
        end
      end
    end

    if dist[dest[0]][dest[1]] == Float::INFINITY
      puts "invalid path"
      @valid = false
      return
    else
      puts "valid path!"
      @valid = true
    end

    @path = []
    node = dest
    while prev[node[0]][node[1]]
      @path.unshift node
      node = prev[node[0]][node[1]]
    end
  end

  def draw
    Gosu.scale(2) do
      Gosu.draw_rect @source[0] * 32, @source[1] * 32, 32, 32, 0xff_ffffff
      Gosu.draw_rect @dest[0] * 32, @dest[1] * 32, 32, 32, 0xff_ff0000

      return unless @valid
      @path.each do |tile|
        Gosu.draw_rect tile[0] * 32, tile[1] * 32, 32, 32, 0x33_00ff00
      end
    end
  end
end
