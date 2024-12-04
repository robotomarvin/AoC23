# frozen_string_literal: true
# typed: true

require_relative '../../lib/autoload'

@sum = 0
m = I.to_map
m.each do |vv|
  next if vv.value != 'A'
  words = Vector2::DDIRS.map do |d|
    w = ''
    start = vv.vector - d
    3.times do |i|
      cv = d*i
      next unless m.exists?(start + cv)

      w += m[start + cv]
    end
    w
  end
  @sum += 1 if words.count('MAS') == 2
end
p @sum
