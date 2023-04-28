extends Control


var file = File.new()
var gold_count = 100

var player_name = ""

var player_info={}
var player_list={}
var id_list=[]
var player_count=1
var net_id=0

var new_game = 0

onready var save_dir = "res://Saves"
var mini_game1="res://Table.tscn"

var glass1 = {'bought' : 0,
			  'lvl': 1,
			  'upgrade': 10,
			  'upgrade_cost': 10,
			  '300ml_water3': 0,
			  '150ml_water2': 0,
			  '150ml_honey': 0,
			  '300ml_honey':0}
			
var glass2 = {'bought' : 0}
var glass3 = {'bought' : 0}

func set_info():
	player_info["username"] = player_name
	player_list[1]=player_info

func _process(delta):
	save_load()

func set_ids():
	net_id = get_tree().get_network_unique_id()
	id_list= get_tree().get_network_connected_peers()

func print_gold():
	$goldtext.text = ": " + str(gold_count)
	
func _ready():
	load_data()
	$Name.text=player_name
	save_load()
	print_gold()
	
	
func take_gold(gold):
	gold_count+=gold
	print_gold()

func purchase(gold):
	gold_count-=gold
	print_gold()

func info_gold():
	return gold_count
	
func _on_Play_pressed():
	$Panel.visible=false

func _on_Button2_pressed():
	get_tree().quit()

func load_glass1(name):
	return glass1[name]

func glass1_info(name, count):
	glass1[name] = count

func save_load():
	file.open("user://Goldcount.txt", file.WRITE)
	file.store_line(str(gold_count))
	file.store_line(player_name)
	file.close()
	
	file.open("user://Glass1.txt", file.WRITE)
	file.store_line(str(glass1['bought']))
	file.store_line(str(glass1['lvl']))
	file.store_line(str(glass1['upgrade']))
	file.store_line(str(glass1['upgrade_cost']))
	file.store_line(str(glass1['150ml_water2']))
	file.store_line(str(glass1['300ml_water3']))
	file.store_line(str(glass1['150ml_honey']))
	file.store_line(str(glass1['300ml_honey']))
	file.close()
	
func load_data():
	if file.file_exists("user://Goldcount.txt"):
		file.open("user://Goldcount.txt", file.READ)
		gold_count = file.get_line().to_int()
		player_name = file.get_line()
		file.close()
	else:
		file.open("user://Goldcount.txt", file.READ)
		file.close()
	
	if file.file_exists("user://Goldcount.txt"):
		file.open("user://Glass1.txt", file.READ)
		glass1['bought'] = file.get_line().to_int()
		glass1['lvl'] = file.get_line().to_int()
		glass1['upgrade'] = file.get_line().to_int()
		glass1['upgrade_cost'] = file.get_line().to_int()
		glass1['150ml_water2'] = file.get_line().to_int()
		glass1['300ml_water3'] = file.get_line().to_int()
		glass1['150ml_honey'] = file.get_line().to_int()
		glass1['300ml_honey'] = file.get_line().to_int()
		file.close()
	else:
		file.open("user://Glass1.txt", file.READ)
		file.close()
	



#Market button
func _on_TextureButton_pressed():
	if $MarketPanel.visible == false:
		$MarketPanel.visible = true
	else:
		$MarketPanel.visible = false


func _on_Glass1Button_pressed():
	$MarketPanel/Glass1Button.text = "bought"
	if gold_count >= 100 and !(glass1['bought']):
		glass1['bought'] = 1
		purchase(100)
		print("Glass 1 bough:", glass1['bought'])
	else:
		print("Enable to buy!!!")
		

func _on_Glass2Button_pressed():
	if gold_count >= 1000 and !(glass2['bought']):
		glass2['bought'] = 1
		purchase(1000)
		print("Glass 2 bough:", glass2['bought'])
	else:
		print("Enable to buy!!!")


func _on_Glass3Button_pressed():
	if gold_count >= 10000 and !(glass3['bought']):
		glass3['bought'] = 1
		purchase(10000)
		print("Glass 3 bough:", glass3['bought'])
	else:
		print("Enable to buy!!!")


