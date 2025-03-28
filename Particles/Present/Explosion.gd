extends GPUParticles2D

@export var auto_remove_delay: float = 0.1


func _ready() -> void:
	var total_duration = lifetime + auto_remove_delay
	var timer = Timer.new()

	timer.wait_time = total_duration
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	
	restart()
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
