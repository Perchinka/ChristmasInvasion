extends Node2D


func instantiate_gpuparticles(particles_scene: PackedScene, pos: Vector2) -> Node:
	if particles_scene == null:
		push_error("No particles scene provided!")
		return null
	var particles_instance = particles_scene.instantiate()
	particles_instance.position = pos
	add_child(particles_instance)
	return particles_instance
