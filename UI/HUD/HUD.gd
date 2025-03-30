extends CanvasLayer

var presentScore: int = 0
var monsterScore: int = 0

func update_present_score(new_score: int) -> void:
	presentScore = new_score
	$ScoreContainer/PresentScoreLabel.text = str(presentScore)

func update_monster_score(new_score: int) -> void:
	monsterScore = new_score
