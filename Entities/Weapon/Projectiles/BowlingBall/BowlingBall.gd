extends Projectile
class_name BowlingBall


func _ready() -> void:
	super()
	lifetime = INF
	gravity_scale = 1.0
	velocity = velocity.normalized() * speed


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		_handle_collision(collision)


func _handle_collision(collision: KinematicCollision2D) -> void:
	if (
		collision.get_collider().is_in_group("floor")
		and collision.get_normal().dot(Vector2(0, -1)) > 0.9
	):
		return

	velocity = velocity.bounce(collision.get_normal()).normalized() * speed
	if impact_effect:
		var effect_instance = impact_effect.instantiate()
		effect_instance.global_position = collision.position
		get_tree().current_scene.add_child(effect_instance)
