l,m=$<.map{|x| x.split(" ").map(&:to_i)}.transpose
p l.map{|x| m.count(x)*x}.sum
