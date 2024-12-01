# frozen_string_literal: true
# typed: strict

require_relative '../../lib/autoload'

m = I.to_map.map do |item|
  next nil if item.value == '.'
  next item.value.to_i if item.value.numeric?

  next item.value
end

sum = 0
m.each do |vv|
  next if vv.value.nil?
  next unless vv.value.is_a? Integer

  found = T.let(false, T::Boolean)
  Vector2::EDIRS.each do |d|
    v = vv.vector + d
    next unless m.exists?(v)

    found = true if m[v].is_a? String
  end
  next unless found

  left = vv.vector
  right = vv.vector
  left += Vector2::LEFT while m.exists?(left + Vector2::LEFT) && (m[left + Vector2::LEFT].is_a? Integer)
  right += Vector2::RIGHT while m.exists?(right + Vector2::RIGHT) && (m[right + Vector2::RIGHT].is_a? Integer)
  num = ''
  left.to(right) do |v|
    num += m[v].to_s
    m[v] = nil
  end
  sum += num.to_i
end
p sum
