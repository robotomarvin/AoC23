def cards_val cards
	map_c = cards.chars.group_by{|x|x}
	j_count = (map_c["J"] || []).size
	map_c = map_c.reject{|x| x=="J"}.map{|x,y| y.size}.sort.reverse


	if j_count == 0
		return 7 if map_c[0] == 5 		    # | 5 same
		return 6 if map_c[0] == 4 		    # | 4 same
		return 5 if map_c[0] == 3 && map_c[1] == 2  # | 3-2
		return 4 if map_c[0] == 3		    # | 3
		return 3 if map_c[0] == 2 && map_c[1] == 2  # | 2-2
		return 2 if map_c[0] == 2                   # | 2
		return 1
	end
	if j_count == 1
		return 7 if map_c[0] == 4 		    # | 5 same
		return 6 if map_c[0] == 3 		    # | 4 same
		return 5 if map_c[0] == 2 && map_c[1] == 2  # | 3-2
		return 4 if map_c[0] == 2		    # | 3
		return 2

	end
	if j_count == 2
		return 7 if map_c[0] == 3 		    # | 5 same
		return 6 if map_c[0] == 2 		    # | 4 same
		return 4
	end
	if j_count == 3
		return 7 if map_c[0] == 2 		    # | 5 same
		return 6 if map_c[0] == 1 		    # | 4 same
	end
	return 7
end
data = $<.map{|x|
	cards, rank = x.chomp.split
	val = cards_val cards
	[(val.to_s + cards.gsub(/A|K|Q|J|T/, {"T"=>"a","J"=>"1","Q"=>"c","K"=>"d","A"=>"e"})).to_i(16), rank]
}
p data.sort_by{|x| x[0]}.map.with_index{|x,i| x[1].to_i * (i+1)}.sum
