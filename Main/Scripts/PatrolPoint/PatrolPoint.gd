extends CharacterBody2D

#@export (String, "loop", "linear") var partol_type = "linear"

@export var SPEED = 50

var disabled = false
var enabled = false

func _ready():
	pass # Replace with function body.

#func patrol(_delta):
#		PathFollow2D.offset += SPEED * _delta
#	else:
#		pass

func _physics_process(_delta):
	get_parent().set_progress(get_parent().get_progress() * SPEED * _delta)
#		patrol(_delta)

func _on_Timer_timeout():
	pass
