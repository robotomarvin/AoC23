@map = $<.map{|line| line.chomp.chars}
@w = @map[0].size
@h = @map.size
n = (0..9).to_a.map(&:to_s)
@nums = @map.map{|line| line.map{|c| n.include?(c) ? c : nil}}
@chars = @map.map{|line| line.map{|c| c == '*' ? '*' : nil}}
@dirs = [-1,0,1].repeated_permutation(2).reject{|x| x[0] == 0 && x[1] == 0}
@sum = 0

def exists? (x,y)
	y >= 0 && y < @h && x >= 0 && x < @w
end
def proces_num(x,y)
	if @nums[y][x] == nil
		return
	end

	left, right = x, x
	left -= 1 while exists?(left-1, y) && @nums[y][left-1] != nil
	right += 1 while exists?(right-1, y) && @nums[y][right+1] != nil

	(@nums[y][left..right]*"").to_i
end
def proces_char(x,y)
	nums = []
	@dirs.each do |dir|
		new_x = x+dir[0]
		new_y = y+dir[1]
		next unless exists?(new_x, new_y)
		n = proces_num(new_x, new_y)
		nums.append n unless n == nil
	end
	nums.uniq!
	return if nums.size != 2
	@sum += nums.inject :*
end

@h.times do |y|
	@w.times do |x|
		next if @chars[y][x] == nil
		proces_char(x,y)
	end
end
p @sum
