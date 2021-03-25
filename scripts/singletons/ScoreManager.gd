extends "res://scripts/singletons/Manager.gd"

var scoreboard_template : Dictionary = {
	"0": {
		"player": "[empty]",
		"score": 0
	},
	"1": {
		"player": "[empty]",
		"score": 0
	},
	"2": {
		"player": "[empty]",
		"score": 0
	},
	"3": {
		"player": "[empty]",
		"score": 0
	},
	"4": {
		"player": "[empty]",
		"score": 0
	},
	"5": {
		"player": "[empty]",
		"score": 0
	},
	"6": {
		"player": "[empty]",
		"score": 0
	},
	"7": {
		"player": "[empty]",
		"score": 0
	},
	"8": {
		"player": "[empty]",
		"score": 0
	},
	"9": {
		"player": "[empty]",
		"score": 0
	}
}

func add_new_score(player : String, new_score : int) -> void:
	var scores : Dictionary = get_scores()
	var setter_score : int = new_score
	for key in scores:
		var next_key : int = int(key) + 1
		if(!(str(next_key) in scores)):
			next_key = int(key)
		if(new_score > scores[str(key)].score):
			scores[str(next_key)].score = scores[str(key)].score
			scores[str(next_key)].player = scores[str(key)].player
			scores[str(key)].score = new_score
			scores[str(key)].player = player
			new_score = scores[str(next_key)].score
			player = scores[str(next_key)].player
			
	JsonHelper.save_dictionary("res://persistance/highscores.json", scores)
		

func set_scoreboard_score(score_key : String, score_player : String, new_score : int):
	var highscores : Dictionary = JsonHelper.get_as_dictionary("res://persistance/highscores.json", scoreboard_template)
	highscores[score_key].score = new_score
	highscores[score_key].player = score_player
	JsonHelper.save_dictionary("res://persistance/highscores.json", highscores)
	
func get_scores() -> Dictionary:
	var highscores : Dictionary = JsonHelper.get_as_dictionary("res://persistance/highscores.json", scoreboard_template)
	return highscores
