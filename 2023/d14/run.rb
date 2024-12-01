map = $<.map{|x|
	x.chomp.chars
}
w = map[0].size
h = map.size

sum = 0
w.times do |i|
	cur_h = h
	h.times do |j|
		if map[j][i] == 'O'
			sum += cur_h
			cur_h -= 1
			next
		end

		if map[j][i] == '#'
			cur_h = h - j - 1
		end
	end
end

p sum
