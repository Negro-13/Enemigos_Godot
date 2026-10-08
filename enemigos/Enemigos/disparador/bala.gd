extends CharacterBody2D

@export var speed: float = 300.0
@export var max_distance: float = 500.0

var direction := Vector2.ZERO
var start_position := Vector2.ZERO

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

	if global_position.distance_to(start_position) >= max_distance:
		queue_free()
