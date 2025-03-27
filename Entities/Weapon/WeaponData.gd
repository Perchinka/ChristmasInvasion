extends Resource
class_name WeaponData

@export var fire_rate: float = 0.3
@export var projectile_scene: PackedScene

@export var projectile_speed: float = 400.0
@export var spread_angle: float = 5.0
@export var projectiles_per_shot: int = 1

@export var recoil_amount: float = 2.0

@export var muzzle_flash: PackedScene
@export var sound_effect: AudioStream

@export var weapon_name: String = "Placeholder"
@export var weapon_icon: Texture
