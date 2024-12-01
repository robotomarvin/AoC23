m = $<.map{|x|
  x.chomp.chars
}
@h = m.size
@w = m[0].size
queue = Queue.new
counts = {
  0 => 0,
  1 => 0,
}

@filled = {}
@h.times do |i|
  @w.times do |j|
    if m[i][j] == 'S'
      queue << [i, j, 0]
      key = "#{i}:#{j}"
      @filled[key] = true
      m[i][j] = 0
      counts[0] += 1
    end
  end
end
dirs = [
  [0, 1],
  [0, -1],
  [1, 0],
  [-1, 0],
]

mem = {}
a,b,c = [65, 196, 327] # N%H, N%H+H, N%H+2H

while queue.size > 0 do
  h, w, count = queue.pop
  if count == a && !mem.key?(a)
    mem[a] = counts[a%2]
  end
  if count == b && !mem.key?(b)
    mem[b] = counts[b%2]
  end
  if count == c && !mem.key?(c)
    mem[c] = counts[c%2]
    break
  end
  dirs.each do |dir|
    new_h = h + dir[0]
    new_w = w + dir[1]
    key = "#{new_h}:#{new_w}"
    next if m[(new_h % @h)][(new_w % @w)] == '#'
    next if @filled[key]
    @filled[key] = true
    counts[(count+1)%2] += 1
    queue << [new_h, new_w, count + 1]
  end
end

p mem.values
# https://www.wolframalpha.com/input?i=interpolating+polynomial+calculator&assumption=%7B%22F%22%2C+%22InterpolatingPolynomialCalculator%22%2C+%22data2%22%7D+-%3E%22%7B%7B65%2C3720%7D%2C%7B196%2C33150%7D%2C%7B327%2C91890%7D%7D%22
# https://www.wolframalpha.com/input?i=%2814655+26501365%5E2%29%2F17161+%2B+%2830375+26501365%29%2F17161+-+52830%2F17161
