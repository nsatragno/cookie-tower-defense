class PathFinder
  attr_reader :valid
  attr_reader :path
  attr_writer :color

  def initialize(map, source, dest, color = 0x33_00ff00)
    @color = color

    @source = source
    @dest = dest

    @unvisited = []
    @dist = []
    (0...Tileset::WIDTH).each do |i|
      line = []
      (0...Tileset::HEIGHT).each do |j|
        line << Float::INFINITY
        @unvisited << [i, j]
      end
      @dist << line
    end

    @prev = @dist.map do |line|
      line.map do |j|
        nil
      end
    end

    @dist[dest[0]][dest[1]] = 0

    while not @unvisited.empty?
      # find node with the least distance
      node = @unvisited[0]
      @unvisited.each do |unvisited|
        if @dist[unvisited[0]][unvisited[1]] < @dist[node[0]][node[1]]
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
        distance = @dist[node[0]][node[1]] + 1
        if distance < @dist[neighbour[0]][neighbour[1]]
          @dist[neighbour[0]][neighbour[1]] = distance
          @prev[neighbour[0]][neighbour[1]] = node
        end
      end
    end

    if accessible? source
      @valid = true
    else
      puts "invalid"
      @valid = false
      return
    end

    @path = calculate_path(source)
  end

  def calculate_path(node)
    path = []
    while @prev[node[0]][node[1]]
      path.unshift node
      node = @prev[node[0]][node[1]]
    end
    path.reverse
  end

  def accessible?(node)
    @dist[node[0]][node[1]] != Float::INFINITY
  end

  def draw
    Gosu.draw_rect @source[0] * 32, @source[1] * 32, 32, 32, 0xff_ffffff
    Gosu.draw_rect @dest[0] * 32, @dest[1] * 32, 32, 32, 0xff_ff0000

    return unless @valid
    @path.each do |tile|
      Gosu.draw_rect tile[0] * 32, tile[1] * 32, 32, 32, @color
    end
  end
end
