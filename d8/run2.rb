inst = gets.chomp.chars.map{|x|x=="L"?0:1}
gets
starts=[]
map = $<.map{|x|
	a=x.chomp.split(?=).map{|y| y.tr(' ()', '')}
	starts += [a[0]] if a[0][2] == "A"
	[a[0], a[1].split(',')]
}.to_h

in_l = inst.length

p starts.map{|c|
	l = 0
	i = 0
	while c[2] != "Z"
		c = map[c][inst[i]]
		i = (i+1)%in_l
		l += 1
	end
	l
}.inject(&:lcm)
