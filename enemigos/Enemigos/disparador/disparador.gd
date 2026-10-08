extends CharacterBody2D

@export var rango: float = 300.0
@export var tiempo_entre_disparos: float = 1.0
@export var proyectil: PackedScene

var player = null
var puede_disparar = true

@onready var raycast = $RayCast2D
@onready var timer = $Timer
@onready var shoot_point = $ShootPoint

func _ready() -> void:
	timer.wait_time = tiempo_entre_disparos
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return

	var distancia = global_position.distance_to(player.global_position)

	if distancia <= rango:
		raycast.target_position = raycast.to_local(player.global_position)
		raycast.force_raycast_update()

		if raycast.is_colliding():
			var objetivo = raycast.get_collider()

			if objetivo.is_in_group("player"):
				if puede_disparar:
					disparar()

func disparar() -> void:
	puede_disparar = false
	timer.start()

	var bala = proyectil.instantiate()
	get_tree().current_scene.add_child(bala)

	bala.global_position = shoot_point.global_position
	bala.start_position = bala.global_position
	bala.direction = (player.global_position - shoot_point.global_position).normalized()
	

func _on_timer_timeout() -> void:
	puede_disparar = true
