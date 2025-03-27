extends RigidBody2D
class_name Projectile

@export var projectile_data: ProjectileData

var damage: int
var speed: float

var has_lifetime: bool
var lifetime: float

var splash_radius: float
var splash_effect: PackedScene

var bounces: int

var impact_effect: PackedScene
var trail_effect: PackedScene

var velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	if projectile_data:
		damage = projectile_data.damage
		speed = projectile_data.speed

		has_lifetime = projectile_data.has_lifetime
		lifetime = projectile_data.lifetime

		gravity_scale = projectile_data.gravity_scale
		splash_radius = projectile_data.splash_radius
		bounces = projectile_data.bounces
		impact_effect = projectile_data.impact_effect
		trail_effect = projectile_data.trail_effect
	else:
		push_error("ProjectileData resource is not assigned!")

	velocity = Vector2.RIGHT.rotated(rotation) * speed

	if trail_effect:
		var trail_instance = trail_effect.instantiate()
		add_child(trail_instance)


func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
		return

	if gravity_scale != 0:
		velocity.y += gravity_scale * delta

	var collision = move_and_collide(velocity * delta)
	if collision:
		_handle_collision(collision)


func _handle_collision(collision: KinematicCollision2D) -> void:
	if collision.get_collider().has_method("apply_damage"):
		collision.collider.apply_damage(damage)

	if impact_effect:
		var effect_instance = impact_effect.instantiate()
		effect_instance.global_position = collision.position
		get_tree().current_scene.add_child(effect_instance)

	if splash_radius > 0:
		pass  # TODO Replace with actual logic for looking for object in radius

	if bounces > 0:
		bounces -= 1
		velocity = velocity.bounce(collision.get_normal())
	else:
		queue_free()
