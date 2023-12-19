inst, tc = ($<.map{|x| x.chomp}*"\n").split("\n\n")
inst = inst.split("\n").map{|x|
  name, rest = x.split("{")
  rules = rest[0...-1].split(",").map{|y|
    parts = y.split(":")
    if parts.size == 1
      cond = 'a~0'
      target = parts[0]
    else
      cond = parts[0]
      target = parts[1]
    end
    cond_source = cond[0]
    cond_dir = cond[1]
    cond_number = cond[2..-1]
    [cond_source, cond_dir, cond_number.to_i, target]
  }
  [name, rules]
}.to_h

def eval_cond dir, cond_number, val
  if dir == '~'
      return true
  end
  if dir == '<'
    return val < cond_number
  end

  return val > cond_number
end

p tc.split("\n").map{|x|
  x = x[1...-1].split(',').map{|y|
    l,r = y.split('=')
    [l, r.to_i]
  }.to_h

  cur_inst = inst['in']
  resolution = nil
  while resolution == nil do
    cur_inst.each do |cond|
      res = eval_cond(cond[1], cond[2], x[cond[0]])
      next unless res
      target = cond[3]
      if target == 'A' || target == 'R'
        resolution = target
        break
      end
      cur_inst = inst[target]
      break
    end
  end

  if resolution == 'A'
    x.map{|x| x[1]}.sum
  else
    0
  end
}.sum