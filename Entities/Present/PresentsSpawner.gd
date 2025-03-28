extends Node2D

@export var max_presents: int = 2
@export var spawn_points: Array[Node2D] = []
@export var present_scene: PackedScene

var active_presents: Array = []
var last_spawn_index: int = -1


func _ready() -> void:
	randomize()
	for i in range(max_presents):
		spawn_present()


func spawn_present() -> void:
	if spawn_points.is_empty() or present_scene == null:
		push_warning("No spawn positions or present scene set!")
		return

	var spawn_index: int = randi() % spawn_points.size()
	if spawn_points.size() > 1:
		while spawn_index == last_spawn_index:
			spawn_index = randi() % spawn_points.size()
	last_spawn_index = spawn_index

	var pos: Vector2 = spawn_points[spawn_index].position
	var present_instance = present_scene.instantiate()
	present_instance.position = pos
	add_child(present_instance)
	active_presents.append(present_instance)

	if present_instance.has_signal("picked_up"):
		present_instance.connect("picked_up", Callable(self, "_on_present_picked_up"))
	else:
		print("Warning: present instance does not have a 'picked_up' signal.")


func _on_present_picked_up(present_instance):
	if present_instance in active_presents:
		active_presents.erase(present_instance)
	if is_instance_valid(present_instance):
		present_instance.queue_free()
		Game.add_present_score(1)

	if active_presents.size() < max_presents:
		call_deferred("spawn_present")
