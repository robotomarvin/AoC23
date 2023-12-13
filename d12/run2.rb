@memory = {}
@space = -1
def solve_part pattern, nums, must=nil
	return 0 if pattern.include?('#') && nums.size == 0
	return 1 if nums[0] == 0 && pattern.size == 0
	if pattern.size == 0
		return 0 if must == '#'
		return 0 if nums.size != 0
		return 0 if nums.size[0] != 0
		return 1
	end
	return solve_part_mem pattern[0...-1], nums[0...-1], '.' if nums[-1] == 0
	return 1 if nums.size == 0


	total = 0

	must ||= pattern.last == '?' ? nil : pattern.last
	sub_pattern = pattern[0...-1]

	if must == nil
		total += solve_part_mem sub_pattern, nums
		if nums[-1] == 1
			total += solve_part_mem sub_pattern, nums[0...-1], '.'
		else
			total += solve_part_mem sub_pattern, nums[0...-1] + [nums[-1] - 1], '#'
		end
	elsif must == '#' && (pattern[-1] == '#' || pattern[-1] == '?')
		if nums[-1] == 1
			total += solve_part_mem sub_pattern, nums[0...-1], '.'
		else
			total += solve_part_mem sub_pattern, nums[0...-1] + [nums[-1] - 1], '#'
		end
	elsif must == '.'
		if pattern[-1] == '.' || pattern[-1] == '?'
			total += solve_part_mem sub_pattern, nums
		end
	end
	total
end
def solve_part_mem pattern, nums, must=nil
	key = pattern*"" + ':' + nums*"," + ':' + must.to_s
	@space += 1
	#puts " "*@space + key + " => start"
	@memory[key] ||= solve_part pattern, nums, must
	#puts " "*@space + key + " => " + @memory[key].to_s
	@space -= 1
	return @memory[key]
end

p $<.map.with_index{|x, i|
	pattern, nums = x.chomp.split
	pattern = ([pattern]*5)*"?"
	nums = nums.split(',').map(&:to_i)*5
	c = pattern.chars

	solve_part_mem c, nums, nil
}.sum
