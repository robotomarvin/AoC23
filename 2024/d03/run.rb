p $<.map(&:chomp).inject(:+).scan(/mul\(\d{1,3}\,\d{1,3}\)/).map{|x|x.scan(/(\d+)\,(\d+)/)[0].split(',').map(&:to_i).inject(:*)}.inject(:+)
