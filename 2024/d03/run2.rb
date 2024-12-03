p $<.map(&:chomp).inject(:+).scan(/mul\(\d{1,3}\,\d{1,3}\)|do\(\)|don't\(\)/).map{|x|
  next true if x=='do()'
  next false if x=='don\'t()'
  x.scan(/\d+\,\d+/)[0].split(',').map(&:to_i).inject(:*)
}.inject([0,true]){|x,y|
  next [x[0]+y*(x[1]?1:0),x[1]] if y.is_a? Integer
  next [x[0],y==true]
}[0]
