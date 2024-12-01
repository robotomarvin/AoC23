p $<.map.with_index{|x, i|
	pattern, nums = x.chomp.split
	nums = nums.split(',').map(&:to_i).map{|y|
		(2**y-1).to_s(2)
	}
	c = pattern.chars
	min = (c.map{|y| y=='#' ? '1' : '0'}*"").to_i(2)
	max = (c.map{|y| y=='.' ? '0' : '1'}*"").to_i(2)
	s = (min..max).select{|y| (y|max)==max && (y&min)==min}.select{|y|
		 y.to_s(2).split("0").reject{|z|z==""} === nums
	}.size
	p [i, s]
	s
}.sum
