extends Node2D

var selected = false
var sound_1= 1
onready var rand = get_node("../../randmusic")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("Click"):
		give_info()

func give_info():
	rand.get_inform(sound_1)