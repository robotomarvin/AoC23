# frozen_string_literal: true
# typed: strict

class Vector2Value
  extend T::Sig
  extend T::Generic

  Elem = type_member

  sig { returns(Vector2) }
  attr_reader :vector

  sig { returns(Elem) }
  attr_reader :value

  sig { params(vector2: Vector2, value: Elem).void }
  def initialize(vector2, value)
    @vector = vector2
    @value = value
  end
end
