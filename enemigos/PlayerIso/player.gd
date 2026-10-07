extends CharacterBody2D

@export var speed := 200.0

func _physics_process(delta):
	var input = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input.length() > 1:
		input = input.normalized()

	velocity = input * speed
	move_and_slide()
