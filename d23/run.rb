map = $<.map{|x|x.chomp.chars}
start = [0,1]
stop = [map.size-1, map[0].size - 2]
@h_max = map.size
@w_max = map[0].size
dirs = {
  '.' => [[0,1], [0,-1], [1,0], [-1,0]],
  '>' => [[0,1]],
  '<' => [[0,-1]],
  'v' => [[1,0]],
  '^' => [[-1,0]],
}

visited = {}
visited =
queue = Queue.new
queue << [start, [start].to_set, 0]
while queue.size > 0
  point, path, l = queue.pop
  h, w = point
  if stop == point
    p l
  end
  dirs[map[h][w]].each do |dir|
    new_h = h+dir[0]
    new_w = w+dir[1]
    next if new_h < 0 || new_h >= @h_max
    next if new_w < 0 || new_w >= @w_max
    next if map[new_h][new_w] == '#'
    next if path === [new_h, new_w]
    set_clone = path.clone
    set_clone << [new_h, new_w]
    queue << [[new_h, new_w], set_clone, l + 1]
  end
end