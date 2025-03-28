extends Node2D

@export var max_presents: int = 2

@export var spawn_points: Array[Node2D] = []

@export var present_scene: PackedScene

var active_presents: Array = []


func _ready() -> void:
	randomize()
	for i in range(max_presents):
		spawn_present()


func spawn_present() -> void:
	if spawn_points.is_empty() or present_scene == null:
		push_warning("No spawn positions or present scene set!")
		return

	var pos: Vector2 = spawn_points[randi() % spawn_points.size()].position
	var present_instance = present_scene.instantiate()
	present_instance.position = pos
	add_child(present_instance)
	active_presents.append(present_instance)

	if present_instance.has_signal("picked_up"):
		present_instance.connect("picked_up", _on_present_picked_up)
	else:
		print("Warning: present instance does not have a 'picked_up' signal.")


func _on_present_picked_up(present_instance):
	if present_instance in active_presents:
		active_presents.erase(present_instance)
	if is_instance_valid(present_instance):
		present_instance.queue_free()

	if active_presents.size() < max_presents:
		call_deferred("spawn_present")
