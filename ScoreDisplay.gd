extends Label

var temp_score = 0

func _process(delta):
	if temp_score != Globals.player_score:
		set_text("Score: " + str(Globals.player_score))
	temp_score = Globals.player_score
