m={"one"=>1,"two"=>2,"three"=>3,"four"=>4,"five"=>5,"six"=>6,"seven"=>7,"eight"=>8,"nine"=>9}
p $<.map{|l| c=l.scan(Regexp.new("(?=(#{m.keys*"|"}|\\d))")).flatten.map{|x|(m[x] || x).to_s};(c[0]+c[-1]).to_i}.sum
