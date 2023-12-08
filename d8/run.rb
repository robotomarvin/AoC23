inst = gets.chomp.chars.map{|x| x=="L" ? 0 : 1}
gets
map = $<.map{|x|
	a=x.chomp.split(?=).map{|y| y.tr(' ()', '')}
	[a[0], a[1].split(',')]
}.to_h

l = 0
i = 0
in_l = inst.length
current = "AAA"
while current != "ZZZ"
	current = map[current][inst[i]]
	i = (i+1)%in_l
	l += 1
end

p l
