class Map
  def initialize data
    @w = data.size
    @h = data[0].size
    @data = data
  end

  def [] vector
    @data[vector.x][vector.y]
  end
  def []= vector, value
    @data[vector.x][vector.y] = value
  end

  def exists? vector
    return false if vector.x < 0
    return false if vector.y < 0
    return false if vector.x >= @w
    return false if vector.y >= @h
    true
  end

  def each &block
    @w.times do |x|
      @h.times do |y|
        yield Vector2Value.new(Vector2.new(x,y), @data[x][y])
      end
    end
  end

  def map &block
    new_data = []
    @w.times do |x|
      new_data[x] = []
      @h.times do |y|
        new_data[x][y] = yield Vector2Value.new(Vector2.new(x,y), @data[x][y])
      end
    end
    Map.new(new_data)
  end

  def to_s
    out = ""
    @w.times do |x|
      @h.times do |y|
        if @data[x][y] == nil
          out += ' '
        else
          out += @data[x][y].to_s
        end
      end
      out += "\n"
    end
    out
  end
end
