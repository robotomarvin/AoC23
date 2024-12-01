@modules = $<.map{|x|
  label, targets = x.chomp.split("->").map(&:strip)
  type = nil
  if label[0] == '%' || label[0] == '&'
    type = label[0]
    label = label[1..-1]
  end
  targets = targets.split(", ")
  [label, [type, targets, {}]]
}.to_h
@modules.each do |x|
  label = x[0]
  targets = x[1][1]
  targets.each do |target|
    next if @modules[target] == nil
    next if @modules[target][0] != '&'
    @modules[target][2][label] = 0
  end
end

@counts = {0 => 0, 1 => 0}
q = Queue.new

max = 100000000000000000000
max.times do |i|
p i if i%10000 == 0
q << ['broadcaster', 0, 'button']
while q.size > 0 do
  label, t, from = q.pop
  @counts[t] += 1

  if label == 'rx' && t == 0
    puts "#{from} -> #{t} -> #{label}"
    puts i
    exit
  end
  next if @modules[label] == nil
  type, targets = @modules[label]
  if type == nil # broadcast
    targets.each do |new_target|
      q << [new_target, t, label]
    end
    next
  end
  if type == '&' # conjunction
    @modules[label][2][from] = t
    p [i, from] if label == 'vd' && t == 1
    t = 1-@modules[label][2].values.inject(:&)
    targets.each do |new_target|
      q << [new_target, t, label]
    end
    next
  end
  next if t == 1 # flip-flop - high
  if type == '%'
    @modules[label][0] = '~'
    t = 1
  else
    @modules[label][0] = '%'
    t = 0
  end

  targets.each do |new_target|
    q << [new_target, t, label]
  end

end
p [i, @modules['vd'][2]] if @modules['vd'][2].values.sum > 0
end

p @counts.values.inject(:*)

