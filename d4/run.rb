p $<.map{|l|n=l.split(':')[1].split('|').map(&:strip).map{|x|x.split(/\s+/)}.inject(&:intersection).size;n==0?0:2**(n-1)}.sum
