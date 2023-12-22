bricks = $<.map{|x|
  x.chomp.split('~').map{|y| y.split(',').map(&:to_i)}
}
bricks.sort_by!{|x| x[0][2]}
max_x = bricks.map{|x| x.map{|y| y[0]}}.flatten.max
max_y = bricks.map{|x| x.map{|y| y[1]}}.flatten.max
single_support = {}
supports = Array.new(max_x+1){Array.new(max_y+1){[1, -1]}}
graph = []
rev = []
bricks.each.with_index do |brick, i|
  graph[i] = []
  rev[i] = []
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
      if supports[x][y][0] == z_max && supports[x][y][1] != -1
        temp_supports[supports[x][y][1]] = true
        rev[supports[x][y][1]] << i
        graph[i] << supports[x][y][1]
      end
      supports[x][y] = [z_max+z_diff, i]
    end
  end
  graph[i].uniq!

  #p [i, temp_supports.keys]
  if temp_supports.keys.size == 1
    single_support[temp_supports.keys[0]] = true
  end
end

total_count = 0
rev.each.with_index do |init_c, i|
    removed = {i => true}
    queue = Queue.new
    init_c.each{|x| queue << x}
    step_count = 0
    while queue.size > 0
      child = queue.pop
      next if removed.key? child
      not_removed = graph[child].select{|x| !removed.key?(x)}
      next if not_removed.size > 0
      rev[child].each{|x| queue << x}
      removed[child] = true
      step_count += 1
    end
    total_count += step_count
end
p total_count
exit

#p graph
#puts "graph {"
#graph.each.with_index do |v, i|
  #v.each do |j|
    #s = j
    #e = i
    #s = ('A'.ord + i).chr
    #e = ('A'.ord + j).chr
    #puts "#{s} -> #{e}"
  #end
#end
#puts "}"
#p rev


#p bricks.size - single_support.keys.select{|x| x >= 0}.size