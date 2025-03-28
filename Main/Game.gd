extends Node2D

const SAVE_FILE_PATH: String = "user://high_score.save"
var ENCRYPTION_KEY: PackedByteArray = "JustMessingAround".to_utf8_buffer()

var present_score: int = 0
var monster_score: int = 0  # TODO

var presents_high_score: int = 0
var monsters_high_score: int = 0


func _ready() -> void:
	pass


func add_present_score(points: int) -> void:
	print("Hey")
	present_score += points


func add_monster_score(points: int) -> void:
	monster_score += points


func save_score() -> void:
	var data: Dictionary = {
		"monsters_highscore": monsters_high_score, "presents_highscore": presents_high_score
	}

	var file: FileAccess = FileAccess.open_encrypted(
		SAVE_FILE_PATH, FileAccess.WRITE, ENCRYPTION_KEY
	)
	if file:
		file.store_var(data)
		file.close()
	else:
		push_error("Failed to open encrypted file for saving high scores.")


func load_high_score() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file: FileAccess = FileAccess.open_encrypted(
			SAVE_FILE_PATH, FileAccess.READ, ENCRYPTION_KEY
		)
		if file:
			var data: Dictionary = file.get_var()
			if data.has("monsters_highscore") and data.has("presents_highscore"):
				monsters_high_score = int(data["monsters_highscore"])
				presents_high_score = int(data["presents_highscore"])
			else:
				push_error("High score file data is invalid.")
			file.close()
		else:
			push_error("Failed to open encrypted file for reading high scores.")
	else:
		# File does not exist, defaults to 0
		monsters_high_score = 0
		presents_high_score = 0
