@map = $<.map{|x|
	x.chomp.chars
}
@w = @map[0].size
@h = @map.size

def move_map map, dir
  new_map = Array.new(@h){|x| Array.new(@w, '.')}
  if dir == 'U' || dir == 'D'
    h_iterator = (0...@h).each if dir == 'U'
    h_iterator = (0...@h).reverse_each if dir == 'D'
    next_place_dir = dir == 'D' ? -1 : 1

    #p h_iterator
    @w.times do |i|
      next_place = h_iterator.peek
      h_iterator.each do |j|
        next_place = j + next_place_dir if @map[j][i] == '#'
        if map[j][i] == 'O'
          new_map[next_place][i] = 'O'
          next_place += next_place_dir
        end
      end
      h_iterator.rewind
    end
  else
    w_iterator = (0...@w).each if dir == 'L'
    w_iterator = (0...@w).reverse_each if dir == 'R'
    next_place_dir = dir == 'R' ? -1 : 1

    @h.times do |j|
      next_place = w_iterator.peek
      w_iterator.each do |i|
        next_place = i + next_place_dir if @map[j][i] == '#'
        if map[j][i] == 'O'
          new_map[j][next_place] = 'O'
          next_place += next_place_dir
        end
      end
      w_iterator.rewind
    end
  end
  new_map
end
def print_map map
  @h.times do |j|
    @w.times do |i|
      if @map[j][i] == '#'
        print '#'
      else
        print map[j][i]
      end
    end
    print "\n"
  end
end

def do_cycle map
  move_map(move_map(move_map(move_map(map, 'U'), 'L'), 'D'), 'R')
end
@cache = {}
@cycle_cache = {}
def do_cycle_mem map, i
  key = map.hash
  @cache[key] ||= [do_cycle(map), i]
  out = @cache[key]
  @cycle_cache[i] = out[0]
  out
end
map = @map
cycle = 0
cycles = 1000000000
cycle_min = cycles + 1
cycle_max = -1
cycles.times do |i|
  map, prev_i = do_cycle_mem(map, i)
  if prev_i != i
   cycle_min = [prev_i, cycle_min].min
   cycle_max = [prev_i, cycle_max].max
   if i > cycle_max*10
     break
   end
  end
end
cycle_len = cycle_max - cycle_min + 1
last_cycle_equal = cycle_min + ((cycles - cycle_min -1) % (cycle_len))
#p [cycle_min, cycle_max, cycle_len, last_cycle_equal]
map = @cycle_cache[last_cycle_equal]
#print_map map
#map = move_map map, 'U'
#print_map map

sum = 0
@w.times do |i|
	@h.times do |j|
		if map[j][i] == 'O'
			sum += @h-j
		end
	end
end

p sum
