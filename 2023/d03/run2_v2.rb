# frozen_string_literal: true
# typed: true

require_relative '../../lib/autoload'

m = I.to_map.map do |item|
  next nil if item.value == '.'
  next item.value.to_i if item.value.numeric?

  next item.value
end

sum = 0
m.each do |vv|
  next unless vv.value == '*'

  found = []
  Vector2::EDIRS.each do |d|
    v = vv.vector + d
    next unless m.exists?(v)

    found << v if m[v].is_a? Integer
  end
  next if found.empty?

  vs = found.map do |nv|
    left = nv
    right = nv
    left += Vector2::LEFT while m.exists?(left + Vector2::LEFT) && (m[left + Vector2::LEFT].is_a? Integer)
    right += Vector2::RIGHT while m.exists?(right + Vector2::RIGHT) && (m[right + Vector2::RIGHT].is_a? Integer)
    [left, right]
  end
  vs.uniq!
  next if vs.size != 2

  sum += vs.uniq.map do |x|
    n = ''
    x[0].to(x[1]) { |v| n += m[v].to_s }
    n.to_i
  end.inject(:*)
end

p sum
