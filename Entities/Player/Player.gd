extends CharacterBody2D

@onready var visuals = $Visuals
@onready var sprite: AnimatedSprite2D = $Visuals/AnimatedSprite2D
@onready var run_particles = $Visuals/RunParticles
@onready var weapon: WeaponHolder = $Visuals/WeaponHolder

@export var speed := 300.0
@export var acceleration := 2000.0
@export var air_acceleration := 1000.0

@export var jump_force := -450.0
@export var max_jump_time := 0.25
@export var gravity := 1200.0
@export var fall_multiplier := 1.8
@export var low_jump_multiplier := 2.5

@export var coyote_time := 0.15
@export var jump_buffer_time := 0.1  # full buffer time when on floor

var jump_timer := 0.0
var coyote_timer := 0.0
var jump_buffer_timer := 0.0

var jump_held := false


func _physics_process(delta: float) -> void:
	handle_horizontal_input(delta)
	handle_jump_input(delta)
	apply_gravity(delta)

	if Input.is_action_pressed("shoot"):
		weapon.fire_weapon()

	update_animation()
	move_and_slide()


func handle_horizontal_input(delta: float) -> void:
	var input_dir := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var accel := acceleration if is_on_floor() else air_acceleration
	velocity.x = move_toward(velocity.x, input_dir * speed, accel * delta)


func handle_jump_input(delta: float) -> void:
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump_buffer_timer = 1
		else:
			jump_buffer_timer = jump_buffer_time

	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_force
		jump_timer = max_jump_time
		jump_held = true
		jump_buffer_timer = 0.0

	elif Input.is_action_just_released("jump"):
		jump_held = false

	if jump_held:
		jump_timer -= delta
		if jump_timer <= 0:
			jump_held = false


func apply_gravity(delta: float) -> void:
	var gravity_scale := 1.0
	if velocity.y < 0 and not jump_held:
		gravity_scale = low_jump_multiplier
	elif velocity.y > 0:
		gravity_scale = fall_multiplier
	velocity.y += gravity * gravity_scale * delta


func update_animation() -> void:
	if not is_on_floor():
		run_particles.emitting = false
	elif abs(velocity.x) > 0:
		sprite.play("run")
		run_particles.emitting = true
	else:
		sprite.play("idle")
		run_particles.emitting = false

	if velocity.x != 0:
		visuals.scale.x = -1.0 if velocity.x < 0 else 1.0
