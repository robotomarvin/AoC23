@map = $<.map{|line| line.chomp.chars}
@w = @map[0].size
@h = @map.size
n = (0..9).to_a.map(&:to_s)
@nums = @map.map{|line| line.map{|c| n.include?(c) ? c : nil}}
@chars = @map.map{|line| line.map{|c| n.include?(c) ? nil : (c == '.' ? nil : c)}}
@dirs = [
		[-1,-1],
		[-1,0],
		[-1,1],
		[1,-1],
		[1,0],
		[1,1],
		[0,-1],
		[0,+1],
]
@sum = 0

def exists? (x,y)
	y >= 0 && y < @h && x >= 0 && x < @w
end
def proces_num(x,y)
	if @nums[y][x] == nil
			return
	end

	left = x
	right = x
	while exists?(left-1, y) && @nums[y][left-1] != nil do
		left -= 1
	end
	while exists?(right-1, y) && @nums[y][right+1] != nil do
		right += 1
	end

	@sum += (@nums[y][left..right]*"").to_i
	(left..right).each do |x|
			@nums[y][x] = nil
	end
end
def proces_char(x,y)
	@dirs.each do |dir|
		new_x = x+dir[0]
		new_y = y+dir[1]
		next unless exists?(new_x, new_y)
		proces_num(new_x, new_y)
	end
end

@h.times do |y|
	@w.times do |x|
		next if @chars[y][x] == nil
		proces_char(x,y)
	end
end
p @sum
