extends Control

var id

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func _connected_ok():
	$Panel/Chat_Box.text+="Entered Room \n"

func _player_connected(id):
	$Panel/Chat_Box.text+= str(id) + "has Connected \n"

func _player_disconnected(id):
	$Panel/Chat_Box.text+= str(id) + "has Discsonnectid \n"

func _server_disconnected():
	$Panel/Chat_Box.text+="Server has Disconected \n"

func _connected_fail():
	$Panel/Chat_Box.text+="Connection Fail \n"

func host_chat():
	var host = NetworkedMultiplayerENet.new() 
	host.create_server(8080)
	get_tree().network_peer = host

func join_room():
	var ip =$Panel2/IP.text
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, 8080)
	get_tree().network_peer = host
	

func send_message():
	var message = $Panel/Text_to_send.text
	id = get_tree().get_network_unique_id()
	rpc("receive_message", id, message)
	$Panel/Text_to_send.text=""	

sync func receive_message(id, message):
	$Panel/Chat_Box.text += str(id)+": " + message + "\n"


func _on_Chat_pressed():
	$Panel.visible=true
	$Panel2.visible = true
	$Chat.visible=false

func _on_Chat2_pressed():
	$Chat.visible=true
	$Panel2.visible = false
	$Panel.visible=false


func _on_Host_pressed():
	host_chat()



func _on_Connect_pressed():
	join_room()


func _on_Leave_pressed():
	get_tree().network_peer = null


func _on_Send_Button_pressed():
	send_message()
