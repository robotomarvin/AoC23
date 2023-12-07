nums = (0..9).to_a.map(&:to_s)
p nums
out = 0
$<.map do |line|
	chars = line.chars
    digs = chars.filter{|x| nums.include?(x)}
    out += (digs[0] + digs[-1]).to_i
end
p out
