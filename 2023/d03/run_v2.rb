require_relative '../../lib/autoload.rb'

m = I::to_map.map{|item|
  next nil if item.value == '.'
  next item.value.to_i if item.value.is_numeric?
  next item.value
}

sum = 0
m.each do |vv|
  next if vv.value == nil
  next unless vv.value.is_a? Integer
  found = false
  Vector2::EDIRS.each do |d|
    v = vv.vector + d
    next unless m.exists?(v)
    if m[v].is_a? String
      found = true
    end
  end
  next unless found
  left = vv.vector
  right = vv.vector
  while (m.exists?(left+Vector2::LEFT) && (m[left+Vector2::LEFT].is_a? Integer)) do
    left = left + Vector2::LEFT
  end
  while (m.exists?(right+Vector2::RIGHT) && (m[right+Vector2::RIGHT].is_a? Integer)) do
    right = right + Vector2::RIGHT
  end
  num = ""
  left.to(right) do |v|
    num += m[v].to_s
    m[v] = nil
  end
  sum += num.to_i
end
p sum
