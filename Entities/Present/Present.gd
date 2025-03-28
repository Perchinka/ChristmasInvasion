extends Area2D

signal picked_up(present_instance)

@export var skins: Array[Texture2D] = []
@export var explosion_scene: PackedScene


func _ready() -> void:
	if skins.size() > 0 and has_node("Sprite"):
		var random_skin = skins[randi() % skins.size()]
		$Sprite.texture = random_skin


func _on_body_entered(body: Node2D):
	spawn_explosion()
	emit_signal("picked_up", self)


func spawn_explosion():
	var fx_node = get_tree().get_root().get_node("Game/World/FX")
	if fx_node and explosion_scene:
		fx_node.instantiate_gpuparticles(explosion_scene, position)
