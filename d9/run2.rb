p $<.map{|x|
	top = x.chomp.split.map(&:to_i)
	difs = [top]
	i = 0
	while true do
		zero_only = true

		new_d = []
		j = 1
		while j < difs[i].size
			new_d += [difs[i][j] - difs[i][j-1]]
			j+=1
		end
		break if new_d.reject{|x| x == 0}.size == 0
		i += 1
		difs += [new_d]
	end
	(0...i).to_a.reverse.each do |j|
		difs[j].prepend (-difs[j+1].first + difs[j].first)
	end
	difs[0].first

}.sum
