# frozen_string_literal: true
# typed: strict

class Map
  extend T::Sig
  extend T::Generic

  Elem = type_member

  sig { params(data: T::Array[T::Array[Elem]]).void }
  def initialize(data)
    @w = T.let(data.size, Integer)
    @h = T.let((data[0] || []).size, Integer)
    @data = data
  end

  sig { params(vector: Vector2).returns(T.nilable(Elem)) }
  def [](vector)
    row = @data[vector.x]
    return nil if row.nil?

    row[vector.y]
  end

  sig { params(vector: Vector2, value: Elem).void }
  def []=(vector, value)
    row = @data[vector.x]
    raise 'X does not exist' if row.nil?
    raise 'Y does not exist' if vector.y >= row.size

    row[vector.y] = value
  end

  sig { params(vector: Vector2).returns(T::Boolean) }
  def exists?(vector)
    return false if vector.x.negative?
    return false if vector.y.negative?
    return false if vector.x >= @w
    return false if vector.y >= @h

    true
  end

  sig { params(_block: T.proc.params(arg0: Vector2Value[Elem]).void).void }
  def each(&_block)
    @data.each_with_index do |row, x|
      row.each_with_index do |value, y|
        yield Vector2Value.new(Vector2.new(x, y), value)
      end
    end
  end

  sig do
    type_parameters(:X)
      .params(_block: T.proc.params(arg0: Vector2Value[Elem]).returns(T.type_parameter(:X)))
      .returns(Map[T.type_parameter(:X)])
  end
  def map(&_block)
    new_data = []
    @data.each_with_index do |row, x|
      new_data[x] = []
      row.each_with_index do |value, y|
        new_data[x][y] = yield Vector2Value[Elem].new(Vector2.new(x, y), value)
      end
    end
    Map.new(new_data)
  end

  sig { returns(String) }
  def to_s
    out = ''
    @data.each do |row|
      row.each do |value|
        out += T.unsafe(value).nil? ? ' ' : T.unsafe(value).to_s
      end
      out += "\n"
    end
    out
  end
end
