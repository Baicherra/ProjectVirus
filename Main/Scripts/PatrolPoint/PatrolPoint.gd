extends KinematicBody2D

export (String, "loop", "linear") var partol_type = "linear"

onready var PathFollow2D = get_parent()
export var SPEED = 50

var disabled = false
var enabled = false

func _ready():
	pass # Replace with function body.

func patrol(_delta):
	if partol_type == "loop":
		PathFollow2D.offset += SPEED * _delta
	else:
		pass

func _physics_process(_delta):
	if partol_type == "loop":
		patrol(_delta)

func _on_Timer_timeout():
	pass
