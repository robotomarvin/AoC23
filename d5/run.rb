seeds = gets.chomp.split(":")[1].chomp.split.map(&:to_i)
maps = ($<.map{|x| x}*"").split(/[a-z-]+ map:/).map(&:strip).reject(&:empty?).map{|x| 
	x.split("\n").map{|y| y= y.split.map(&:to_i);{dest:y[1], max: y[1]+y[2]-1, diff:y[0]-y[1]}}.sort_by{|y| y[:dest]}.reverse
}
locations = seeds
maps.each do |map|
	locations.map! do |location|
		r = map.bsearch{|x| x[:dest] <= location}
		r == nil ? location : (location > r[:max] ? location : location + r[:diff])
	end
end

p locations.min

