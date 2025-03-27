extends Node2D
class_name WeaponHolder

@export var weapon_scene: PackedScene  # Assign your weapon scene in the editor.
var current_weapon: Weapon


func _ready() -> void:
	if weapon_scene:
		current_weapon = weapon_scene.instantiate()
		add_child(current_weapon)
		# Optionally, position the weapon relative to the holder.
		current_weapon.position = Vector2.ZERO
	else:
		push_error("No weapon_scene assigned to WeaponHolder!")


func fire_weapon() -> void:
	if current_weapon:
		current_weapon.fire()
