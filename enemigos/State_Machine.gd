extends Node
class_name State_Machine

@onready var controlled_node = owner
@export var default_state: State_base

var current_state: State_base = null


func _ready() -> void:
	call_deferred("_state_default_start")


func _state_default_start():
	if default_state == null:
		push_error("No se asignó un Default State a " + owner.name)
		return

	current_state = default_state
	_state_start()


func _state_start():
	if current_state == null:
		push_error("El estado actual es null.")
		return

	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()


func change_to(new_state: String):
	if current_state and current_state.has_method("end"):
		current_state.end()

	var next = get_node_or_null(new_state)

	if next == null:
		push_error("No existe " + new_state)
		return

	current_state = next
	_state_start()


func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)


func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)
