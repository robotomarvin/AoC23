start = [
	14834422, #pr + #rd
	#3792, #pr
	#3910, #rd
	15389892, #bt + #fv
	#3916, #bt
	#3928, #fv
]
difs = [
	14834423, #pr + #rd
	#3793, #pr
	#3911, #rd
	15389893, #bt + #fv
	#3917, #bt
	#3929, #fv
]
lcm = difs.inject(&:lcm)
p lcm

l = 0
while start.uniq.size > 1 do
	l += 1
	if l > 100000
		p start
		l = 0
	end
	el,i = start.each_with_index.min
	start[i] += difs[i]
end
p start
