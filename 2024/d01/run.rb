p $<.map{|x| x.split(" ").map(&:to_i)}.transpose.map(&:sort).inject(&:zip).sum{|x| (x[0]-x[1]).abs}
