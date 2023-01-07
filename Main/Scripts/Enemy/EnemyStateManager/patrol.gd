class_name PatrolState
extends IdleState

onready var patrol_line = $"../../Patrol_Line"
onready var ray_patrol = $"../../RayPoint"

export var PATROL_SPEED = 70
