@dirs = {
	'R' => [0,1],
	'L' => [0,-1],
	'U' => [-1,0],
	'D' => [1,0],
}
@map = {"0:0" => 1}
@current = [0,0]
@w_start = 0
@w_end = 0
@h_start = 0
@h_end = 0
$<.each{|x|
	dir, len, color = x.split
	dir = @dirs[dir]
	len = len.to_i
	len.times do
		@current = @current.zip(dir).map(&:sum)
		@map["#{@current[0]}:#{@current[1]}"] = 1
		@w_start = [@current[1], @w_start].min
		@w_end = [@current[1], @w_end].max
		@h_start = [@current[0], @h_start].min
		@h_end = [@current[0], @h_end].max
	end
}

count = 0
(@h_start..@h_end).each.with_index do |h,i|
	inside = false
	last = '?'
	row_count = 0
	(@w_start..@w_end).each do |w|
		c = @map.has_key?("#{h}:#{w}") ? '#' : '.'
		if @map.has_key?("#{h}:#{w}")
			row_count += 1
			if @map.has_key?("#{h-1}:#{w}")
				c = 'U'
			end
			if @map.has_key?("#{h+1}:#{w}")
				if c == 'U'
					c = '|'
				else
					c = 'D'
				end
			end
			if c == '|'
				inside = !inside
			end
			if (c == 'U' || c == 'D')
				if last != c && (last == 'U' || last == 'D')
					inside = !inside
				end
				last = c
			end
			#c = "~"
		else
			last = '?'
			if inside
				c = "~"
				row_count += 1
			end
		end
		#print c
	end
	count += row_count
	p [i-233, row_count]
	#print "\n"
end

#p count
#count += @map.size

p count
#p [@w_start, @w_end, @h_start, @h_end]
#p @map
