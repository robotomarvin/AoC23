require_relative '../build/z3/lib/z3'

storms = $<.map{|x|
  x.chomp.split(" @ ").map{|y| y.split(", ").map(&:to_i)}
}[0..2]

solver = Z3::Solver.new

result_dir = (0..2).to_a.map{|i| Z3.Real("d#{i}")}
result_start = (0..2).to_a.map{|i| Z3.Real("p#{i}")}
storms.each.with_index do |storm, i|
  p, v = storm
  t = Z3.Real("t#{i}")
  3.times do |j|
    exp = result_start[j] + t*result_dir[j] == p[j] + t*v[j]
    solver.assert(exp)
    p exp
  end
end
p solver

if solver.satisfiable?
  p result_start.map{|x| solver.model[x].to_s.to_i}.sum
end
