bricks = $<.map{|x|
  x.chomp.split('~').map{|y| y.split(',').map(&:to_i)}
}
bricks.sort_by!{|x| x[0][2]}
max_x = bricks.map{|x| x.map{|y| y[0]}}.flatten.max
max_y = bricks.map{|x| x.map{|y| y[1]}}.flatten.max
single_support = {}
supports = Array.new(max_x+1){Array.new(max_y+1){[1, -1]}}
bricks.each.with_index do |brick, i|
  from, to = brick
  x_from = from[0]
  x_to = to[0]
  y_from = from[1]
  y_to = to[1]
  z_max = (x_from..x_to).map{|x|
    (y_from..y_to).map do |y|
      supports[x][y][0]
    end
  }.flatten.max
  z_diff = (to[2]-from[2]) + 1

  temp_supports = {}
  (x_from..x_to).each do |x|
    (y_from..y_to).map do |y|
      temp_supports[supports[x][y][1]] = true if supports[x][y][0] == z_max
      supports[x][y] = [z_max+z_diff, i]
    end
  end

  p [i, temp_supports.keys]
  if temp_supports.keys.size == 1
    single_support[temp_supports.keys[0]] = true
  end
end

p bricks.size - single_support.keys.select{|x| x >= 0}.size