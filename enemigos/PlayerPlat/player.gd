
extends CharacterBody2D
class_name Player

@export var move_speed := 150.0
@export var acceleration := 800.0
@export var friction := 1000.0

@export var jump_force := 350.0
@export var gravity := 1000.0

var direction := 0.0
var facing_direction := 1


func _physics_process(delta):
	# Movimiento horizontal
	direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = move_toward(
			velocity.x,
			direction * move_speed,
			acceleration * delta
		)

		facing_direction = sign(direction)

	else:
		velocity.x = move_toward(
			velocity.x,
			0,
			friction * delta
		)

	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()
