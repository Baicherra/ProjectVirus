class_name IdleState
extends BaseState

export (NodePath) var patrolling_node
export (NodePath) var hunting_node

onready var patrolling_state: BaseState = get_node(patrolling_node)
onready var hunting_state: BaseState = get_node(hunting_node)

var velocity = Vector2.ZERO
var path: Array = []

var can_patrol = false
var can_hunt = false

var LevelNavigation: Navigation2D = null
var player = null 
var patrol_point = null

var start_patrol = true

onready var point_moving = false
onready var player_spotted := false

func _ready(): # ПОЛУЧИТЬ ВСЁ НУЖНОЕ ИЗ СЦЕНЫ
	yield(get_tree(), "idle_frame")
	
	var tree = get_tree()
	if tree.has_group("HuntNavigation"):
		LevelNavigation = tree.get_nodes_in_group("HuntNavigation")[0] 
	
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
	
	if tree.has_group("PatrolPoint"):
		player = tree.get_nodes_in_group("PatrolPoint")[0]
