class LineRange
	attr_accessor :ranges
	def initialize
		@ranges = []
	end

	def get_sum
		@ranges.map{|x| x[1] - x[0] + 1}.sum
	end
	def get_sum_with ranges, i
		starts = (@ranges.map{|x| x[0]} + ranges.map{|x| x[0]}).map{|x| [x, 1]}
		ends = (@ranges.map{|x| x[1]} + ranges.map{|x| x[1]}).map{|x| [x, -1]}
		points = (starts + ends).sort_by{|x| x[0]}.group_by{|x| x[0]}.map{|x| [x[0], x[1].sum{|x| x[1]}]}.reject{|x| x[1] == 0}
		count = 0
		sum = 0
		last = nil
		points.each do |point|
		    if count == 0 && point[1] > 0
				last = point[0]
		    end
		    count += point[1]

			if count == 0
				sum += point[0] - last + 1
			end
		end

		sum
	end


	def prune!
		@ranges = @ranges.flatten.sort.group_by{|x| x}.map{|x| x}.select{|x| x[1].size%2 == 1}.map{|x| x[0]}.each_slice(2).to_a
	end
	def add range
		@ranges.push(range)
	end
	def print
		p @ranges
	end
end

@dirs = {
	'0' => [0,1],
	'2' => [0,-1],
	'3' => [-1,0],
	'1' => [1,0],
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
lines = $<.map{|x|
	dir, len, color = x.split
	color = color.gsub("(","").gsub(")","").gsub("#","")
	len = color[0...-1].to_i(16)
	dir = @dirs[color[-1]]
	#len = len.to_i
	#dir = @dirs[dir]
	from = @current
	@current = @current.zip(dir.map{|y| y*len}).map(&:sum)
	[from, @current, dir[0] == 0]
}.select{|x| x[2]}.sort_by{|x| x[0][0]}.group_by{|x| x[0][0]}.map{|x|
	[x[0], x[1].map{|y| [y[0][1], y[1][1]].sort}.sort_by{|y| y[0]}]
}.to_h
lr = LineRange.new
last_line = nil
count = 0
#p lines
lines.each do |x|
	i, ranges = x
	count
	
	if last_line != nil && last_line+1 != i
        count += lr.get_sum * (i - (last_line + 1))
	end
	last_line = i
	ranges.each do |r|
		lr.add r
	end
	lr.prune!
	count += lr.get_sum_with(ranges,i)
end

p count
#p [@w_start, @w_end, @h_start, @h_end]
#p @map
