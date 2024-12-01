require_relative '../../lib/autoload.rb'

m = I::to_map.map{|item|
  next nil if item.value == '.'
  next item.value.to_i if item.value.is_numeric?
  next item.value
}

sum = 0
m.each do |vv|
  next unless vv.value == '*'
  found = []
  Vector2::EDIRS.each do |d|
    v = vv.vector + d
    next unless m.exists?(v)
    if m[v].is_a? Integer
      found << v
    end
  end
  next if found.size == 0
  vs = found.map do |nv|
    left = nv
    right = nv
    while (m.exists?(left+Vector2::LEFT) && (m[left+Vector2::LEFT].is_a? Integer)) do
      left = left + Vector2::LEFT
    end
    while (m.exists?(right+Vector2::RIGHT) && (m[right+Vector2::RIGHT].is_a? Integer)) do
      right = right + Vector2::RIGHT
    end
    [left, right]
  end
  vs.uniq!
  next if vs.size != 2
  num = vs.uniq.map{|x|
    num = ""
    x[0].to(x[1]) {|v| num += m[v].to_s}
    num.to_i
  }.inject(:*)
  sum += num
end

p sum
