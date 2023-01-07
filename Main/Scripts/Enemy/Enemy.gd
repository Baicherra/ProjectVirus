extends KinematicBody2D
class_name Enemy

export var path_to_hunt := NodePath()
export var path_to_point := NodePath()
export var path_to_scent := NodePath()

var velocity := Vector2.ZERO

var PATROL_SPEED = 30
var HUNT_SPEED = 70
var SCENT_SPEED = 50

onready var agent: NavigationAgent2D = $NavigationAgent2D

onready var timer := $Timer

onready var patrol_line = $Patrol_Line
onready var hunt_line = $Hunt_Line
onready var scent_line = $Scent_Line

onready var ray_point = $RayPoint
onready var ray_hunt = $RayPlayer
onready var ray_scent = $RayScent

onready var player := $"../Player"
onready var patrol_point := $"../Path2D/PathFollow2D/PatrolPoint"

var patrol_mode := false
var hunt_mode := false
var scent_mode := false

var player_spotted := false
var scent_spotted := false

func _ready() -> void:
	timer.connect("timeout", self, "_update_pathfinding")

func _physics_process(_delta: float) -> void:
	if patrol_point and patrol_mode == true:
		ray_point.look_at(patrol_point.global_position)
		patrol_line.global_position = Vector2.ZERO
		generate_path()
		_update_pathfinding()
		print("PATROL MODE")
	if player:
		ray_hunt.look_at(player.global_position)
		check_player_in_detection()
		if player_spotted == true:
			hunt_line.global_position = Vector2.ZERO
			generate_path()
			_update_pathfinding()
			print("HUNT MODE")
		if scent_spotted == true:
			generate_path()
			_update_pathfinding()
			print("SCENT MODE")
	move()
	
	if agent.is_navigation_finished():
		return
	
# ФУНКЦИЯ ЛУЧАvelocity
func check_player_in_detection():
	var collider = ray_hunt.get_collider()
	if collider and collider.is_in_group("Player"):
		player_spotted = true
		hunt_mode = true
		
		patrol_mode = false
		return true
	else:
		hunt_mode = false
		
		scent_mode = true
		check_scent_in_detection()
	return false
	
func check_scent_in_detection():
	for scent in player.scent_trail:
		var collider = ray_scent.get_collider()
		ray_scent.look_at(scent.global_position)
		if collider and collider.is_in_group("Scent"):
			print("collided")
			scent_spotted = true
			return true
	return false
	
func generate_path():
	if patrol_mode == true and hunt_mode == false:
		var patrol_target_position:= agent.get_next_location()
		velocity = global_position.direction_to(patrol_target_position) * PATROL_SPEED
	
	elif hunt_mode == true and patrol_mode == false:
		var hunt_target_position:= agent.get_next_location()
		velocity = global_position.direction_to(hunt_target_position) * HUNT_SPEED
	
	elif scent_mode == true:
		var scent_target_position:= agent.get_next_location()
		velocity = global_position.direction_to(scent_target_position) * SCENT_SPEED
	
func _update_pathfinding() -> void:
	if patrol_mode == true and hunt_mode == false: 
		agent.set_target_location(patrol_point.global_position)
		
	elif hunt_mode == true and patrol_mode == false:
		agent.set_target_location(player.global_position)
		
	elif scent_mode == true:
		for scent in player.scent_trail:
			agent.set_target_location(scent.global_position)
		
func move() -> void:
	velocity = move_and_slide(velocity)
	
# РАДИУС ТЕРРОРА МОНСТРА
func _on_EnemyTerrorLVL_area_entered(_area: Node2D) -> void:
	print("entered")

func _on_EnemyTerrorLVL_area_exited(_area: Node2D) -> void:
	print("exited")

func _on_NavigationAgent2D_velocity_computed(safe_velocity):
	velocity = safe_velocity
