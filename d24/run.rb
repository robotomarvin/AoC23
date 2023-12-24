storms = $<.map{|x|
  x.chomp.split(" @ ").map{|y| y.split(", ").map(&:to_i)}
}

count = 0
storms.each.with_index do |a, i|
  storms.each.with_index do |b, j|
    next if i>=j
    dx = b[0][0] - a[0][0]
    dy = b[0][1] - a[0][1]
    det = b[1][0] * a[1][1] - b[1][1] * a[1][0]
    next if det == 0
    u = (dy * b[1][0] - dx * b[1][1]) / det.to_f
    v = (dy * a[1][0] - dx * a[1][1]) / det.to_f
    next if u < 0 || v < 0

    x = a[0][0] + a[1][0] * u
    y = a[0][1] + a[1][1] * u

    next if x < 200000000000000 || x > 400000000000000
    next if y < 200000000000000 || y > 400000000000000
    count += 1
  end
end

p count