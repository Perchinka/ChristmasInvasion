extends Resource
class_name ProjectileData

@export var damage: int = 1
@export var speed: float = 400.0

@export var has_lifetime: bool = false
@export var lifetime: float = 3.0

@export var gravity_scale: float = 0.0  # 0 means no gravity; >0 makes it fall

@export var splash_radius: float = 0.0  # If > 0 - apply area damage on impact
@export var splash_effect: PackedScene

@export var bounces: int = 0  # Number of allowed bounces before destruction

@export var impact_effect: PackedScene  # Spawn this effect on collision
@export var trail_effect: PackedScene  # A visual trail during flight
