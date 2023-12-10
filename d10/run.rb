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
m = $<.map.with_index{|x, i|
	x.chomp.chars.map.with_index{|y, j|
		@start = [i,j] if y == "S"
		y == '.' ? nil : y
	}
}

i,j = @start
p @start
dir = 'l'
l = 0
while true
	#p [i, j, m[i][j], dir]
	m[i][j] = l
	i += @dirs[dir][1]
	j += @dirs[dir][0]
	break if i == @start[0] && j == @start[1]
	dir = @map[m[i][j]][dir]
	l += 1
end
p (l+1)/2
