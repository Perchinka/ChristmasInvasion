extends Area2D

signal picked_up(present_instance)

@export var skins: Array[Texture2D] = []


func _ready() -> void:
	if skins.size() > 0 and has_node("Sprite"):
		var random_skin = skins[randi() % skins.size()]
		$Sprite.texture = random_skin


func _on_body_entered(body: Node2D):
	emit_signal("picked_up", self)
