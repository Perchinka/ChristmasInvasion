extends Projectile
class_name BowlingBall


func _ready() -> void:
	add_to_group("bowling_ball")
	super()
	gravity_scale = 1.0
	velocity = velocity.normalized() * speed
	lifetime = INF


func _physics_process(delta: float) -> void:
	velocity.y += gravity_scale * delta
	var collision = move_and_collide(velocity * delta)
	if collision:
		_handle_collision(collision)


func _handle_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	var normal = collision.get_normal()

	if collider.is_in_group("player"):
		return

	if collider.is_in_group("ground") and normal.dot(Vector2(0, -1)) > 0.9:
		velocity = velocity.slide(normal)
		return

	if (
		(collider.is_in_group("ground") and abs(normal.dot(Vector2(1, 0))) > 0.9)
		or collider.is_in_group("bowling_ball")
	):
		velocity = velocity.bounce(normal).normalized() * speed
		if impact_effect:
			var effect_instance = impact_effect.instantiate()
			effect_instance.global_position = collision.position
			get_tree().current_scene.add_child(effect_instance)
		return

	velocity = velocity.slide(normal)
