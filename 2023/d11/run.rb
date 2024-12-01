m = $<.map{|x|
	x.chomp.chars
}
h = m.size
w = m[0].size
#p m
#p [h,w]
total_l = 0
stars = 0
curr_l = 0
h.times do |i|
	local_count = 0
	w.times do |j|
		local_count += 1 if m[i][j] == "#"
	end
	diff = local_count == 0 ? 2 : 1
	total_l += local_count * curr_l
	stars += local_count
	curr_l += stars * diff
	#p [local_count, diff, curr_l, stars, total_l]
end

stars = 0
curr_l = 0
w.times do |i|
	local_count = 0
	h.times do |j|
		local_count += 1 if m[j][i] == "#"
	end
	diff = local_count == 0 ? 2 : 1
	total_l += local_count * curr_l
	stars += local_count
	curr_l += stars * diff
	#p [local_count, diff, curr_l, stars, total_l]
end

p total_l
