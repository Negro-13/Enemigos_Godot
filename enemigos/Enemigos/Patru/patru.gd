extends CharacterBody2D

@export var speed := 100.0
@export var gravity := 980.0

@onready var raycasts = $RayCasts
@onready var raycast_pared = $RayCasts/RayCastPared
@onready var raycast_piso = $RayCasts/RayCastPiso
@onready var sprite = $Sprite2D

var direccion := 1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	velocity.x = speed * direccion

	if raycast_pared.is_colliding():
		cambiar_direccion()

	elif not raycast_piso.is_colliding():
		cambiar_direccion()

	move_and_slide()

func cambiar_direccion():
	direccion *= -1
	raycasts.scale.x *= -1
	sprite.flip_h = direccion < 0
