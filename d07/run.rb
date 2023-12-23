def cards_val cards
	map_c = cards.chars.group_by{|x|x}.map{|x,y| y.size}.sort.reverse
	return 7 if map_c[0] == 5
	return 6 if map_c[0] == 4
	return 5 if map_c[0] == 3 && map_c[1] == 2
	return 4 if map_c[0] == 3
	return 3 if map_c[0] == 2 && map_c[1] == 2
	return 2 if map_c[0] == 2
	return 1
end
data = $<.map{|x|
	cards, rank = x.chomp.split
	val = cards_val cards
	[(val.to_s + cards.gsub(/A|K|Q|J|T/, {"T"=>"a","J"=>"b","Q"=>"c","K"=>"d","A"=>"e"})).to_i(16), rank]
}
p data.sort_by{|x| x[0]}.map.with_index{|x,i| x[1].to_i * (i+1)}.sum
