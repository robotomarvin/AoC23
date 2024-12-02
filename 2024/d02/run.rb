p $<.map{|x|
  l = x.split(' ').map(&:to_i)
  z=l[0...-1].zip(l[1..]).map{|y|y[0]-y[1]}
  z.reject{|y|y>=1&&y<=3}==[] || z.reject{|y|y>=-3&&y<=-1}==[]
}.count{|x|x}
