extends BaseState

export (NodePath) var hunting_node
export (NodePath) var idle_node
onready var idle_state: BaseState = get_node(idle_node)
onready var hunting_state: BaseState = get_node(hunting_node)

onready var patrol_line = $"../../Patrol_Line"
onready var ray_patrol = $"../../RayPoint"

export var PATROL_SPEED = 70

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
	
	if tree.has_group("PatrolPoint"):
		player = tree.get_nodes_in_group("PatrolPoint")[0]

# ПРЕСЛЕДОВАНИЕ
func physics_process(_delta: float) -> BaseState:
	if patrol_point:
		ray_patrol.look_at(patrol_point.global_position)
		patrol_line.global_position = Vector2.ZERO
		hunt_generate_path()
		hunt_navigate()
	hunt_move()
	return null
	
# НАВИГАЦИЯ ПУТИ
func hunt_navigate():
	if path.size() > 0:
		velocity = enemy.global_position.direction_to(path[1]) * PATROL_SPEED
		if enemy.global_position == path [0]:
			path.pop_front()
	
# ГЕНЕРАЦИЯ ПУТИ
func hunt_generate_path():
	if LevelNavigation != null and patrol_point != null:
		path = LevelNavigation.get_simple_path(enemy.global_position, patrol_point.global_position, false)
		patrol_line.points = path
	
# ДВИЖЕНИЕ
func hunt_move():
	velocity = enemy.move_and_slide(velocity)
