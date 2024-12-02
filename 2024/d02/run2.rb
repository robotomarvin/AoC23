p $<.map{|x|
  l = x.split(' ').map(&:to_i)
  l.size.times.map {|y|
    b=l[0...y]+l[(y+1)..]
    z=b[0...-1].zip(b[1..]).map{|y|y[0]-y[1]}
    z.reject{|y|y>=1&&y<=3}==[] || z.reject{|y|y>=-3&&y<=-1}==[]
  }.inject(:|)
}.count{|x|x}
