nodes = $<.map{|x|
	from, to = x.split(": ")
	[from, to.split(" ")]
}.to_h
nodes.clone.each do |i, children|
    children.each do |node|
        nodes[node] ||= []
        nodes[node] << i
    end
end
nodes.keys.each do |i|
    nodes[i].uniq!
end

first = nodes.keys.first
queue = [first]
visited = queue.to_set

while queue.size > 0
    node = queue.pop
    nodes[node].each do |n|
        next if visited === n
        queue << n
        visited << n
    end
end

total_count = nodes.keys.size

p visited.size
p total_count - visited.size
