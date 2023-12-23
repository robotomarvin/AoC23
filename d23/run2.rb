require 'algorithms'

map = $<.map{|x|x.chomp.chars.map{|y| y=='#' ? '#' : '.'}}
start = [0,1]
stop = [map.size-1, map[0].size - 2]
@h_max = map.size
@w_max = map[0].size

map[0][1] = 'S'
map[map.size-1][map[0].size - 2] = 'E'
@nodes = {
  'S' => [0, 1, {}],
  'E' => [map.size-1, map[0].size - 2, {}]
}
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
      map[h][w] = id
      @nodes[id] = [h, w, {}]
      id += 1
    end
  end
end

@nodes.each do |n|
  id, data = n
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
        @nodes[id][2][map[new_h][new_w]] = l + 1
        next
      end
      set_clone = path.clone
      set_clone << [new_h, new_w]
      queue << [[new_h, new_w], set_clone, l + 1]
    end
  end
end

graph = @nodes.map{|x| [x[0], x[1][2]]}.to_h

queue = Queue.new
queue << ['S', ['S'].to_set, 0]
top_l = 0
while queue.size > 0
  id, visited, len = queue.pop
  graph[id].each do |target_id, target_len|
    next if visited === target_id
    new_l = len + target_len
    if target_id == "E"
      if new_l > top_l
        top_l = new_l
        p new_l
      end
      next
    end

    new_v = visited.clone
    new_v << target_id
    queue << [target_id, new_v, new_l]
  end
end