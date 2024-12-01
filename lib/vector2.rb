# frozen_string_literal: true
# typed: strict

class Vector2
  extend T::Sig
  sig { returns(Integer) }
  attr_reader :x, :y

  sig { params(x: Integer, y: Integer).void }
  def initialize(x, y)
    @x = x
    @y = y
  end

  sig { params(other: Vector2).returns(Vector2) }
  def +(other)
    Vector2.new(@x + other.x, @y + other.y)
  end

  sig { params(other: Vector2).returns(Vector2) }
  def -(other)
    Vector2.new(@x - other.x, @y - other.y)
  end

  sig { params(other: Vector2).returns(T::Boolean) }
  def eql?(other)
    @x == other.x && @y == other.y
  end
  alias == :eql?

  sig { returns(Integer) }
  def hash
    [@x, @y].hash
  end

  LEFT = T.let(new(0, -1), Vector2)
  RIGHT = T.let(new(0, 1), Vector2)
  UP = T.let(new(-1, 0), Vector2)
  DOWN = T.let(new(1, 0), Vector2)
  LEFT_UP = T.let(LEFT + UP, Vector2)
  LEFT_DOWN = T.let(LEFT + DOWN, Vector2)
  RIGHT_UP = T.let(RIGHT + UP, Vector2)
  RIGHT_DOWN = T.let(RIGHT + DOWN, Vector2)
  DIRS = T.let([LEFT, UP, RIGHT, DOWN].freeze, T::Array[Vector2])
  EDIRS = T.let([LEFT, LEFT_UP, UP, RIGHT_UP, RIGHT, RIGHT_DOWN, DOWN, LEFT_DOWN].freeze, T::Array[Vector2])

  sig { returns(String) }
  def to_s
    "#{@x}:#{@y}"
  end

  sig { returns(String) }
  def inspect
    "#{@x}:#{@y}"
  end

  sig { params(other: Vector2, _block: T.proc.params(arg0: Vector2).void).returns(Vector2) }
  def to(other, &_block)
    x_min = [@x, other.x].min
    x_max = [@x, other.x].max
    y_min = [@y, other.y].min
    y_max = [@y, other.y].max

    (x_min..x_max).each do |x|
      (y_min..y_max).each do |y|
        yield Vector2.new(x, y)
      end
    end
    self
  end
end
