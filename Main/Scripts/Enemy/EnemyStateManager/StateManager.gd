extends Node

export (NodePath) var starting_state

var current_state: BaseState

func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func init(enemy: Enemy) -> void:
	for child in get_children():
			child.enemy = enemy
	
	change_state(get_node(starting_state))
	
func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)

func _process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
