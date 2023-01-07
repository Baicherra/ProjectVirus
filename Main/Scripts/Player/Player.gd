extends CharacterBody2D
class_name Player

######################################################################################
################################## ИГРОК #############################################
######################################################################################

# предзагрузить сцену и запахом
const scent_scene = preload("res://Main/Scenes/Player/Scent.tscn")

var scent_trail = []
var player = []

# уровни страха
var lvl0 = false
var lvl1 = false
var lvl2 = false
var lvl3 = false

@export var SPEED = 80

# получить группу с игроком
func _ready(): 
	pass	
#	$ScentTimer.connect("timeout",Callable(self,"add_scent"))
	
######################################################################################
################################## ЗАПАХ #############################################
######################################################################################
func add_scent():
	pass
#	var scent = scent_scene.instantiate()
#	scent.player = player
#	scent.global_position = player.global_position
#
#	player.get_parent().add_child(scent)
#	scent_trail.push_front(scent)

######################################################################################
############################### ПЕРЕДВИЖЕНИЕ #########################################
######################################################################################
func _physics_process(_delta):
	var INPUT_VECTOR = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	var MOVE_DIRECTION = INPUT_VECTOR.normalized()
	set_velocity(SPEED * MOVE_DIRECTION)
	move_and_slide()
	MOVE_DIRECTION = velocity

######################################################################################
########################### РАДИУС ТЕРРОРА ИГРОКА ####################################
######################################################################################
# Уровень 1 /////////////////////////////////////////////////////////////////////////
func _on_PlayerTerrorLVL1_area_entered(area: Node2D) -> void:
	if area.get_parent().get_node("/root/Level/Player/PlayerTerrorLVL1/RadiusLVL1"):
		print(area.name, " enter lvl1")
		lvl0 = false
		lvl1 = true
	
func _on_PlayerTerrorLVL1_area_exited(area: Node2D) -> void:
	if area.get_parent().get_node("/root/Level/Player/PlayerTerrorLVL1/RadiusLVL1"):
		print(area.name, " exit lvl1")
		lvl0 = true
		lvl1 = false
	
# Уровень 2 /////////////////////////////////////////////////////////////////////////
func _on_PlayerTerrorLVL2_area_entered(area: Node2D) -> void:
	if area.get_parent().get_node("/root/Level/Player/PlayerTerrorLVL2/RadiusLVL2"):
		print(area.name, " enter lvl2")
		lvl1 = false
		lvl2 = true
	
func _on_PlayerTerrorLVL2_area_exited(area: Node2D) -> void:
	if area.get_parent().get_node("/root/Level/Player/PlayerTerrorLVL2/RadiusLVL2"):
		print(area.name, " exit lvl2")
		lvl1 = true
		lvl2 = false
	
# Уровень 3 /////////////////////////////////////////////////////////////////////////
func _on_PlayerTerrorLVL3_area_entered(area: Node2D) -> void:
	if area.get_parent().get_node("/root/Level/Player/PlayerTerrorLVL3/RadiusLVL3"):
		print(area.name, " enter lvl3")
		lvl3 = true
		lvl2 = false

func _on_PlayerTerrorLVL3_area_exited(area: Node2D) -> void:
	if area.get_parent().get_node("/root/Level/Player/PlayerTerrorLVL3/RadiusLVL3"):
		print(area.name, " exit lvl3")
		lvl3 = false
		lvl2 = true

