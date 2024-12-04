# frozen_string_literal: true
# typed: true

require_relative '../../lib/autoload'

m = I.to_map
@sum = 0
m.each do |vv|
  next if vv.value != 'X'
  Vector2::EDIRS.each do |d|
    w = 'X'
    diff = d
    while m.exists?(vv.vector + diff) && 'XMAS'.start_with?(w)
      w += m[vv.vector + diff]
      @sum += 1 if w == 'XMAS'
      diff += d
    end
  end
end
p @sum
