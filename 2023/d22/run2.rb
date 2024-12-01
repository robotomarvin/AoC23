bricks = $<.map{|x|
  from, to = x.chomp.split('~').map{|y| y.split(',').map(&:to_i)}
}.sort_by{|x| x[0][2]}
max_x, max_y = [0,1].map{|i| bricks.map{|x| x.map{|y| y[i]}}.flatten.max}
bricks.map!{|x|
  from, to = x
  [from[0]..to[0], from[1]..to[1], to[2] - from[2] + 1]
}

supports = Array.new(max_x+1){Array.new(max_y+1){[1, -1]}}
child_to_parent = Array.new(bricks.size){[]}
parent_to_child = Array.new(bricks.size){[]}

bricks.each.with_index do |brick, i|
  x_range, y_range, z_diff = brick
  z_max = x_range.map{|x|
    y_range.map{|y|
      supports[x][y][0]
    }.max
  }.max

  x_range.each do |x|
    y_range.map do |y|
      if supports[x][y][0] == z_max && supports[x][y][1] != -1
        parent_to_child[supports[x][y][1]] << i
        child_to_parent[i] << supports[x][y][1]
      end
      supports[x][y] = [z_max+z_diff, i]
    end
  end
  child_to_parent[i].uniq!
end

total_count = 0
parent_to_child.each.with_index do |first_children, i|
    removed = {i => true}
    queue = Queue.new
    first_children.each{|x| queue << x}
    while queue.size > 0
      child = queue.pop
      next if removed.key? child
      next if child_to_parent[child].select{|x| !removed.key?(x)}.size > 0
      parent_to_child[child].each{|x| queue << x}
      removed[child] = true
      total_count += 1
    end
end
p total_count