extends BaseState

export (NodePath) var patrolling_node
export (NodePath) var hunting_node
export (NodePath) var idle_node

onready var patrolling_state: BaseState = get_node(patrolling_node)
onready var hunting_state: BaseState = get_node(hunting_node)
onready var idle_state: BaseState = get_node(idle_node)

func physics_process(_delta: float) -> BaseState:
	if idle_state:
		print("PATROL MODE")
		return patrolling_state
	return null
