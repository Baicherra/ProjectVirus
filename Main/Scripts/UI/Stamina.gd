extends TextureProgress

onready var timer = $Timer
var can_charge = true
var fast_walk = true

func _ready():
	value = 200

func _physics_process(_delta):
	if !Input.get_action_strength("ui_run"):
		$"../../../..".SPEED = 80
	
	if Input.get_action_strength("ui_run"):
		can_charge = false
		timer.start()
		$"../../../..".SPEED = 140
		value -= 1
	
	if value == 0:
		$"../../../..".SPEED = 80
	
	if value == 200 and !Input.get_action_strength("ui_run"):
		$"../../../..".SPEED = 80
	
	if value <= 200 and !Input.get_action_strength("ui_run") and can_charge == true:
		value += 1
		
func _on_Timer_timeout():
	if !Input.get_action_strength("ui_run"):
		can_charge = true
