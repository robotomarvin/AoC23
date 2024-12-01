@start = nil
@dirs = {
	"l" => [-1, 0],
	"d" => [0, 1],
	"r" => [1, 0],
	"u" => [0, -1]
}
@map = {
	"F" => {"l" => "d", "u" => "r"},
	"|" => {"u" => "u", "d" => "d"},
	"-" => {"l" => "l", "r" => "r"},
	"J" => {"d" => "l", "r" => "u"},
	"7" => {"r" => "d", "u" => "l"},
	"L" => {"d" => "r", "l" => "u"}
}
m2 = []
m = $<.map.with_index{|x, i|
	m2[i] = []
	x.chomp.chars.map.with_index{|y, j|
		m2[i][j] = y == '.' ? '.' : ' '
		@start = [i,j] if y == "S"
		y
	}
}

i,j = @start
p @start
dir = 'd'
l = 0
while true
	#p [i, j, m[i][j], dir]
	m2[i][j] = m[i][j]
	m[i][j] = "p"
	i += @dirs[dir][1]
	j += @dirs[dir][0]
	break if i == @start[0] && j == @start[1]
	dir = @map[m[i][j]][dir]
	l += 1
end
m2[@start[0]][@start[1]] = '7'

# puts m2.map{|x| x*""}*"\n"
# p (l+1)/2

p m2.map{|x|
	count = 0
	inside = false
	corner = false
	x.each do |c|
		if c == '.' || c == ' '
			count += 1 if inside
			next
		end
		next if c == '-'
		if c == '|'
			inside = !inside
			next
		end
		if corner == false
			corner = c
		else
			inside = !inside if (corner == 'L' && c == '7') || (corner == 'F' && c == 'J')
			corner = false
		end
	end
	count
}.sum
