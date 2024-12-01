require 'algorithms'

class Move
  attr_accessor :h
  attr_accessor :w
  attr_accessor :dir
  attr_accessor :heat
  attr_accessor :in_row
  @@touched = {}

  def initialize h,w,dir,heat,in_row=1
    @h = h
    @w = w
    @dir = dir
    @heat = heat
    @in_row = in_row
  end
  def get_key
    return "#{@h}:#{@w}"
  end
  def mark
    key = get_key
    res = !@@touched.key?(key) || !@@touched[key].key?(dir)
    if res
      @@touched[key] ||= {}
      @@touched[key][dir] = in_row
    elsif @@touched[key][dir] > in_row
      res = true
      @@touched[key][dir] = in_row
    end
    res
  end
  def valid? max_h, max_w
    return false if @h < 0 || @h >= max_h
    return false if @w < 0 || @w >= max_w
    return false if in_row >= 4
    return mark
  end
  def get_touched
    @@touched
  end
end

@MM = {
  'R' => ['R', 'D', 'U'],
  'L' => ['L', 'D', 'U'],
  'U' => ['U', 'L', 'R'],
  'D' => ['D', 'L', 'R']
}
@dirs = {
  'R' => {h: 0, w: 1},
  'L' => {h: 0, w: -1},
  'U' => {h: -1, w: 0},
  'D' => {h: 1, w: 0}
}

@map = $<.map{|x| x.chomp.chars.map(&:to_i)}
@max_h = @map.size
@max_w = @map[0].size
#p @map

def get_moves original
  directions = @MM[original.dir]
  #p [original, directions]
  possible = directions.map{|dir|
    cor_dif = @dirs[dir]
    new_h = cor_dif[:h] + original.h
    new_w = cor_dif[:w] + original.w
    new_heat = original.heat + ((@map[new_h] || [])[new_w] || 0)
    new_in_row = dir == original.dir ? original.in_row + 1 : 1

    Move.new new_h, new_w, dir, new_heat, new_in_row
  }
  #p possible
  possible.select{|x| x.valid?(@max_h, @max_w)}
end

queue = Containers::PriorityQueue.new
init_moves = [
  Move.new(0,1,'R', @map[0][1]),
  Move.new(1,0,'D', @map[1][0]),
]
init_moves.each do |m|
  m.mark
  queue.push(m, -m.heat)
end

while queue.size > 0
  move = queue.pop
  if move.w == @max_w-1 && move.h == @max_h-1
    p move.heat
    break
  end

  get_moves(move).each do |new_move|
    queue.push(new_move, -new_move.heat)
  end
end