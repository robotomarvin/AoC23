@map = $<.map(&:chomp).map(&:chars)
def get_key h,w
end
class Move
  attr_accessor :h
  attr_accessor :w
  attr_accessor :dir
  @@touched = {}

  def initialize h,w,dir
    @h = h
    @w = w
    @dir = dir
  end
  def get_key
    return "#{@h}:#{@w}"
  end
  def mark
    key = get_key
    res = !@@touched.key?(key) || !@@touched[key].key?(dir)
    if res
      @@touched[key] ||= {}
      @@touched[key][dir] = false
    end
    res
  end
  def valid? max_h, max_w
    return false if @h < 0 || @h >= max_h
    return false if @w < 0 || @w >= max_w
    return mark
  end
  def get_touched
    @@touched
  end
  def reset_touched
    @@touched = {}
  end
end

@MM = {
  'R' => {'.' => ['R'], '-' => ['R'], '|' => ['U', 'D'], '\\' => ['D'], '/' => ['U']},
  'L' => {'.' => ['L'], '-' => ['L'], '|' => ['U', 'D'], '\\' => ['U'], '/' => ['D']},
  'U' => {'.' => ['U'], '|' => ['U'], '-' => ['L', 'R'], '\\' => ['L'], '/' => ['R']},
  'D' => {'.' => ['D'], '|' => ['D'], '-' => ['L', 'R'], '\\' => ['R'], '/' => ['L']}
}
@dirs = {
  'R' => {h: 0, w: 1},
  'L' => {h: 0, w: -1},
  'U' => {h: -1, w: 0},
  'D' => {h: 1, w: 0}
}
@max_h = @map.size
@max_w = @map[0].size
def get_moves original
  directions = @MM[original.dir][@map[original.h][original.w]]
  #p [original, directions]
  possible = directions.map{|dir|
    cor_dif = @dirs[dir]
    Move.new cor_dif[:h] + original.h, cor_dif[:w] + original.w, dir
  }
  #p possible
  possible.select{|x| x.valid?(@max_h, @max_w)}
end

starts =
  (0...@max_w).map{|x| [0, x, 'D']} +
  (0...@max_w).map{|x| [@max_h - 1, x, 'U']} +
  (0...@max_h).map{|x| [x, 0, 'R']} +
  (0...@max_h).map{|x| [x, @max_w - 1, 'L']}
p starts.map{|start|
  h,w,dir = start
  init_key = get_key(h,w)
  move = Move.new(h,w,dir)
  move.reset_touched
  move.mark
  que = Queue.new
  que << move
  while que.size > 0
    move = que.pop
    get_moves(move).each do |new_move|
      #p new_move
      que << new_move
    end
  end
  move.get_touched.size
}.max