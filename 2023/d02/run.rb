p $<.map{|x|
	game, rounds = x.split(":")
	game = game.split(" ")[1].to_i

	rounds = rounds.split(";").map{|y| y.split(',').map(&:strip).map{|z| num, color = z.split(" "); {color => num.to_i}}.inject(&:merge)}
		.inject{|h1,h2| h1.merge(h2){|key,v1,v2| [v1,v2].max}}
	[game, rounds]
}.select{|x| 
	rounds = x[1]
	rounds['red'] <= 12 && rounds['green'] <= 13 && rounds['blue'] <= 14
}.map(&:first).sum
