extends Node2D
class_name WeaponHolder

@export var weapon_scenes: Array[PackedScene] = []
var current_weapon: Weapon = null
var current_index: int = 0


func _ready() -> void:
	if weapon_scenes.size() > 0:
		current_weapon = weapon_scenes[current_index].instantiate()
		add_child(current_weapon)
		current_weapon.position = Vector2.ZERO
	else:
		push_error("No weapon scenes assigned to WeaponHolder!")


func _input(event):
	if event.is_action_pressed("switch_weapon"):
		switch_weapon()


func switch_weapon() -> void:
	if weapon_scenes.is_empty():
		return

	if current_weapon:
		current_weapon.queue_free()

	current_index = (current_index + 1) % weapon_scenes.size()
	current_weapon = weapon_scenes[current_index].instantiate()
	add_child(current_weapon)
	current_weapon.position = Vector2.ZERO


func fire_weapon() -> void:
	if current_weapon:
		current_weapon.fire()
