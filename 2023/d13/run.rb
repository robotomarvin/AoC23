def mirror array
	(1...array.size).each do |i|
		left = i-1
		right = i
		while array[left] == array[right] && left >= 0 && right < array.size
			left -= 1
			right += 1
		end
		if left < 0
			return i
		elsif right >= array.size
			return i
		end
	end
	0
end
p ($<.map(&:chomp)*"\n").split("\n\n").map{|x|
	lines = x.split("\n").map{|y| y.gsub('#', '1').gsub('.', '0')}
	row_nums = lines.map{|y| y.to_i(2)}
	col_nums = (0...lines[0].size).map{|y| (lines.map{|z| z[y]}*"").to_i(2)}

	mirror(col_nums) + mirror(row_nums)*100
}.sum

