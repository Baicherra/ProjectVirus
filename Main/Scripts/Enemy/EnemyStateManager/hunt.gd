class_name HuntState
extends BaseState

export (NodePath) var idle_node
export (NodePath) var patrolling_node

onready var idle_state: BaseState = get_node(idle_node)
onready var patrolling_state: BaseState = get_node(patrolling_node)

onready var hunt_line = $"../../Hunt_Line"
onready var ray_enemy = $"../../RayPlayer"

export var HUNT_SPEED = 70

var velocity = Vector2.ZERO
var path: Array = []

var can_hunt = false

var LevelNavigation: Navigation2D = null
var player = null 

onready var player_spotted := false

func _ready(): # ПОЛУЧИТЬ ВСЁ НУЖНОЕ ИЗ СЦЕНЫ
	yield(get_tree(), "idle_frame")
	
	var tree = get_tree()
	if tree.has_group("HuntNavigation"):
		LevelNavigation = tree.get_nodes_in_group("HuntNavigation")[0] 
	
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
