inst, tc = ($<.map{|x| x.chomp}*"\n").split("\n\n")
@inst = inst.split("\n").map{|x|
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

class SplitRange
  def initialize parts = nil
    @parts = parts || {
      'x' => (1..4000),
      'm' => (1..4000),
      'a' => (1..4000),
      's' => (1..4000),
    }
  end

  def sum
    @parts.map{|x| x[1]}.map(&:size).inject(:*)
  end

  def split_by source, direction, cond_number
    source_val = @parts[source]
    left = source_val.first
    right = source_val.last
    if direction == '<'
      out_t = (left..cond_number-1)
      out_f = (cond_number..right)
    elsif direction == '>'
      out_t = (cond_number+1..right)
      out_f = (left..cond_number)
    end
    t_clone = @parts.clone
    f_clone = @parts.clone
    t_clone[source] = out_t
    f_clone[source] = out_f

    return [SplitRange.new(t_clone), SplitRange.new(f_clone)]
  end

  def to_s
    @parts.map{|x| "#{x[0]} - (#{x[1]})"}
  end
end

@d = 0
def sum_wrap range, k, i=0, s=''
  @d += 1
  sum = sum(range, k, i, s)
  @d -= 1
  #print "|   "*@d
  #print range.to_s
  #print " - #{k} - #{i} - #{s} - "
  #print sum.to_s
  #print "\n"
  sum
end
def sum range, k, i=0, s=''
  return range.sum if k == 'A'
  return 0 if k == 'R'
  return 0 if range.sum == 0

  source, direction, cond_number, target = @inst[k][i]
  return sum_wrap(range, target, 0, '~') if direction == '~'
  ranges = range.split_by(source, direction, cond_number)
  return sum_wrap(ranges[0], target, 0, 'T') + sum_wrap(ranges[1], k, i+1, 'F')
end

p sum_wrap(SplitRange.new, 'in')

