extends Control

var gold_count = 100
var player_name = ""
var player_info={}
var player_list={}
var id_list=[]
var player_count=1
var net_id=0
var mini_game1="res://Table.tscn"

func set_info():
	player_info["username"] = player_name
	player_list[1]=player_info

func set_ids():
	net_id = get_tree().get_network_unique_id()
	id_list= get_tree().get_network_connected_peers()

func print_gold():
	$goldtext.text = ": " + str(gold_count)
	
func _ready():
	print_gold()
	
	
func take_gold(gold):
	gold_count+=gold
	print_gold()

func purchase(gold):
	gold_count-=gold
	print_gold()

func info_gold():
	return gold_count

func _process(delta):
	$UserName.text = str(player_name)
	
func _on_Play_pressed():
	$Panel.visible=false


func _on_LineEdit_text_changed(new_text):
	player_name = $Panel/LineEdit.text
	print(player_name)


func _on_Button2_pressed():
	get_tree().change_scene(mini_game1)
