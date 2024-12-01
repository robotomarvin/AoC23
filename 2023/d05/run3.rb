seeds = gets.chomp.split(":")[1].chomp.split.map(&:to_i).each_slice(2).lazy.flat_map{|x| (x[0]..x[0]+x[1]).lazy}
maps = ($<.map{|x| x}*"").split(/[a-z-]+ map:/).map(&:strip).reject(&:empty?).map{|x| 
	x.split("\n").map{|y| y= y.split.map(&:to_i);{dest:y[1], max: y[1]+y[2]-1, diff:y[0]-y[1]}}.sort_by{|y| y[:dest]}.reverse
}
p seeds
seeds = seeds.map do |location|
	maps.each do |map|
		r = map.bsearch{|x| x[:dest] <= location}
		location = r == nil ? location : (location > r[:max] ? location : location + r[:diff])
	end
	location
end
p seeds

p seeds.min

