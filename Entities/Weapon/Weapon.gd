extends Node2D
class_name Weapon

@export var weapon_data: WeaponData

@export var sprite: Sprite2D
@export var muzzle: Node2D

var _fire_timer: float = 0.0


func _ready() -> void:
	if not sprite:
		push_error("Sprite node is not assigned in Weapon")
	if not muzzle:
		push_error("Muzzle node is not assigned in Weapon")


func _process(delta: float) -> void:
	if _fire_timer > 0:
		_fire_timer -= delta


func can_fire() -> bool:
	return _fire_timer <= 0


func fire() -> void:
	if weapon_data and can_fire():
		_fire_timer = weapon_data.fire_rate

		if weapon_data.projectile_scene:
			var projectile_instance = weapon_data.projectile_scene.instantiate()

			projectile_instance.global_position = muzzle.global_position
			projectile_instance.rotation = muzzle.global_rotation

			get_tree().current_scene.add_child(projectile_instance)
