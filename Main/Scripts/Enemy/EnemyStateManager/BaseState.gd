class_name BaseState
extends Node

export (String) var animation_name

var start := true

var enemy: Enemy

func enter() -> void:
	#enemy.animation.play(animation_name)
	pass
	
func exit() -> void:
	pass

func process(_delta: float) -> BaseState:
	return null

func physics_process(_delta: float) -> BaseState:
	return null
