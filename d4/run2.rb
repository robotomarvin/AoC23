m=$<.map{|l|n=l.split(':')[1].split('|').map(&:strip).map{|x|x.split(/\s+/)}.inject(&:intersection).size}
c=m.map{|x|1}
(0...m.size).each{|i|r=i+m[i];c[i+1..r]=c[i+1..r].map{|x|x+c[i]}}
p c.sum
