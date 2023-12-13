def bit_dif_check a, b
	return 0 if a^b == 0
	Math.log2(a^b) % 1 == 0 ? 1 : 2 ## returning 2 only as other values are not checked
end
def mirror array
	(1...array.size).each do |i|
		left = i-1
		right = i
		dif_req = 1
		while left >= 0 && right < array.size
			diff = bit_dif_check(array[left], array[right])
			break if diff > dif_req
			dif_req -= diff
			left -= 1
			right += 1
		end
		if dif_req != 0
			next
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

