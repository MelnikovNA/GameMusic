extends Control

var id
var file = File.new()
var gold_count = 0;
var player_name = ""

func _ready():
	load_data()
	join_room()
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func load_data():
	if file.file_exists("user://Goldcount.txt"):
		file.open("user://Goldcount.txt", file.READ)
		gold_count = file.get_line().to_int()
		player_name = file.get_line()
		file.close()
	else:
		file.open("user://Goldcount.txt", file.READ)
		file.close()


func _player_connected(id):
	$Panel/RichTextLabel.text+= player_name + " has Connected \n"

func _player_disconnected(id):
	$Panel/RichTextLabel.text+= player_name + " has Discsonnectid \n"

func _server_disconnected():
	$Panel/RichTextLabel.text+="Server has Disconected \n"

func _connected_fail():
	$Panel/RichTextLabel.text+="Connection Fail \n"

func host_chat():
	var host = NetworkedMultiplayerENet.new() 
	host.create_server(8080)
	get_tree().network_peer = host

func join_room():
	var host = NetworkedMultiplayerENet.new()
	host.create_client("sandbox.htc.ru", 8080)
	get_tree().network_peer = host
	

func send_message():
	if($Panel/Text_to_send.text!="\n"):
		rpc_unreliable("send_chat", message_create())
		$Panel/RichTextLabel.bbcode_text+=message_create()
		$Panel/Text_to_send.text=""	
		

remote func send_chat(txt):
	$Panel/RichTextLabel.bbcode_text += txt

func message_create():
	return player_name+": "+$Panel/Text_to_send.text+"\n"


func _on_Chat_pressed():
	$Panel.visible=true
	$Chat.visible=false

func _on_Chat2_pressed():
	$Chat.visible=true
	$Panel.visible=false

func _on_Send_Button_pressed():
	send_message()
