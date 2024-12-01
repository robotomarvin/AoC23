class Vector2
  attr_reader :x
  attr_reader :y
  def initialize x, y
    @x = x
    @y = y
  end

  def + second
    v = Vector2.new(@x+second.x, @y+second.y)
  end

  def - second
    v = Vector2.new(@x-second.x, @y-second.y)
  end

  def eql? second
    @x == second.x && @y == second.y
  end
  alias_method :==, :eql?
  def hash
    [@x,@y].hash
  end

  LEFT = self.new(0,-1)
  RIGHT = self.new(0,1)
  UP = self.new(-1,0)
  DOWN = self.new(1,0)
  LEFT_UP = LEFT + UP
  LEFT_DOWN = LEFT + DOWN
  RIGHT_UP = RIGHT + UP
  RIGHT_DOWN = RIGHT + DOWN
  DIRS = [LEFT, UP, RIGHT, DOWN]
  EDIRS = [LEFT, LEFT_UP, UP, RIGHT_UP, RIGHT, RIGHT_DOWN, DOWN, LEFT_DOWN]

  def to_s
    "#{@x}:#{@y}"
  end
  def inspect
    "#{@x}:#{@y}"
  end

  def to second, &block
    x_min = [@x, second.x].min
    x_max = [@x, second.x].max
    y_min = [@y, second.y].min
    y_max = [@y, second.y].max

    (x_min..x_max).each do |x|
      (y_min..y_max).each do |y|
        yield Vector2.new(x,y)
      end
    end

  end
end
