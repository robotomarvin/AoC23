p gets.chomp.split(",").map{|x|
  num = 0
  if x[-1] == '-'
    label = x[0...-1]
    op = '-'
  else
    label, num = x.split('=')
    num = num.to_i
    op = '+'
  end
  box = label.chars.map(&:ord).inject(0){|out, n| ((out+n)*17)%256}
  [box, label, op, num]
}.group_by{|x| x[0]}.map{|x|
  x[1].inject({}){|box,y|
    if (y[2] == '-')
      box.delete(y[1])
    else
      box[y[1]] = y[3]
    end
    box
  }.map.with_index{|v,i|
    [x[0]+1, i+1, v[1]].inject(:*)
  }.sum
}.sum