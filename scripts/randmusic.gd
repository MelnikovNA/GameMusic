extends Node2D


var rng = RandomNumberGenerator.new()
var my_random_number
var lvl_pass = true
var gold = 10
var lvl_num =0
var l =	"res://MainScen.tscn"
onready var UI  = get_node("res://scripts/Interface.gd")

#150honey - 1
#150water - 2
#300honey - 3

func _process(delta):
	if(lvl_pass):
		my_random_number = rng.randi_range(1, 3)
		print(my_random_number)
		change(my_random_number)
		lvl_pass = false
	
	
	if lvl_num==3:
		end()
	

func change(my_random_number):
	if my_random_number ==1 and !lvl_pass:
		$"2".stop()
		$"3".stop()
		$"1".play()

	
	if my_random_number == 2 and !lvl_pass:
		$"1".stop()
		$"3".stop()
		$"2".play()

	
	if my_random_number == 3 and !lvl_pass:
		$"1".stop()
		$"2".stop()
		$"3".play()
	


func end():
	$"1".stop()
	$"2".stop()
	$"3".stop()
	gold = 0
	get_tree().change_scene(l)

func get_inform(info):
	if info==my_random_number:
		gold*=2
		lvl_num+=1
		lvl_pass=true
		print("WiN")
		
	
