m = $<.map{|x|
  x.chomp.chars
}
@h = m.size
@w = m[0].size
queue = Queue.new
counts = {
  0 => 1,
  1 => 0,
}

@h.times do |i|
  @w.times do |j|
    if m[i][j] == 'S'
      m[i][j] = 0
      queue << [i, j, 0]
    end
  end
end
dirs = [
  [0, 1],
  [0, -1],
  [1, 0],
  [-1, 0],
]

while queue.size > 0 do
  h, w, count = queue.pop
  break if count >= 64
  dirs.each do |dir|
    new_h = h + dir[0]
    new_w = w + dir[1]
    next if new_h < 0 || new_h >= @h
    next if new_w < 0 || new_w >= @w
    next if m[new_h][new_w] != '.'
    m[new_h][new_w] = count + 1
    counts[(count+1)%2] += 1
    queue << [new_h, new_w, count + 1]
  end
end
#puts m.map{|x|x*"\t"}*"\n"

p counts
