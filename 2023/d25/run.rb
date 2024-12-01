puts "graph {"
puts $<.map{|x|
	from, to = x.split(": ")
	to.split(" ").map do |y|
		a,b = [from, y].sort
		label = [from, y].sort*"-"
		"#{a} -- #{b} [label=\"#{label}\"]"
	end
}.flatten.uniq*"\n"
puts "}"
