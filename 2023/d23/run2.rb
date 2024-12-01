require 'algorithms'

map = $<.map{|x|x.chomp.chars.map{|y| y=='#' ? '#' : '.'}}
start = [0,1]
stop = [map.size-1, map[0].size - 2]
@h_max = map.size
@w_max = map[0].size

map[0][1] = 0
map[map.size-1][map[0].size - 2] = 1
@nodes = [
  [0, 1, []],
  [map.size-1, map[0].size - 2, []]
]
dirs = [[0,1], [0,-1], [1,0], [-1,0]]

id = 1
map.size.times do |h|
  map[0].size.times do |w|
    next if map[h][w] != '.'
    c = 0
    dirs.each do |dir|
      new_h = h+dir[0]
      new_w = w+dir[1]
      c += 1 if map[new_h][new_w] == '.'
    end
    if c > 2
      map[h][w] = @nodes.size
      @nodes << [h, w, []]
    end
  end
end

@nodes.each.with_index do |data, id|
  x, y, _ = data
  queue = Queue.new
  queue << [[x, y], [[x, y]].to_set, 0]
  while queue.size > 0
    point, path, l = queue.pop
    h, w = point
    dirs.each do |dir|
      new_h = h+dir[0]
      new_w = w+dir[1]
      next if new_h < 0 || new_h >= @h_max
      next if new_w < 0 || new_w >= @w_max
      next if map[new_h][new_w] == '#'
      next if path === [new_h, new_w]
      if map[new_h][new_w] != '.'
        @nodes[id][2] << [map[new_h][new_w], l + 1]
        next
      end
      set_clone = path.clone
      set_clone << [new_h, new_w]
      queue << [[new_h, new_w], set_clone, l + 1]
    end
  end
end


graph = @nodes.map{|x| x[2]}

queue = []
queue << [0, 1, 0]
top_l = 0
while queue.size > 0
  id, visited, len = queue.pop
  graph[id].each do |child|
    target_bit = 2**child[0]
    next if (visited & target_bit) == target_bit
    if child[0] == 1
      new_l = len + child[1]
      if new_l > top_l
        top_l = new_l
      end
      next
    end

    queue << [child[0], visited | target_bit, len + child[1]]
  end
end

p top_l