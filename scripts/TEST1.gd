extends Area2D

var move_selected = false
var selected = false
var timer_sel = 0
var timer_gold = 0
var timer_on = false
var timer_prev = 0;
var gold = 0
var upgrade = 10
var now_gold = 0
var lvl = 1
var max_lvl = false
var upgrade_cost = 10
onready var UI  = get_node("../../Interface")



func _ready():
	$Panel.visible = false
	$Panel/Types/Panel2.visible=false
	$AnimatedSprite.play("150water")
	#$"../water150".play()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("Click"):
		selected = true
		timer_on = true
		$Panel.visible = true
		

func _process(delta):
	$Panel/takegold.text = str(gold) + " Gold"
	if max_lvl:
		$Panel/info.text = "Glass Max lvl"
		$Panel/Lvlup.text = "Max LVLUP"
	else:
		$Panel/info.text = "Glass " + str(lvl)+ "lvl"
		$Panel/Lvlup.text = str(upgrade_cost)+ " LVLUP"
	timer_gold+=delta
	if ((timer_gold - timer_prev)>1):
		timer_prev=timer_gold
		gold+=upgrade
	
	if(timer_on):
		timer_sel+=delta

	
func _physics_process(delta):
	if selected and (timer_sel>1):
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)

func _input(event):
	if event is InputEventMouseButton:
		#if event.button_index == BUTTON_LEFT and not selected:
		#	$Panel.visible = false
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			timer_on = false
			timer_sel=0
			
		
func _on_takegold_pressed():
	UI.take_gold(gold)
	gold = 0



func _on_Lvlup_pressed():
	now_gold = UI.info_gold()
	print(now_gold)
	if now_gold >= upgrade_cost and lvl<10:
		print(1)
		UI.purchase(upgrade_cost)
		lvl+=1
		upgrade*=2
		upgrade_cost*=4
		if lvl==10:
			max_lvl = true

func _on_Types_pressed():
	$Panel/Types/Panel2.visible = true

func _on_300ml_water3_pressed():
	$AnimatedSprite.play("300water")
	$"../honey150".stop()
	$"../water150".stop()
	$"../honey300".stop()
	$"../water300".play()
	$Panel/Types/Panel2.visible=false


func _on_150ml_honey_pressed():
	$AnimatedSprite.play("150honey")
	$"../honey150".play()
	$"../water150".stop()
	$"../honey300".stop()
	$"../water300".stop()
	$Panel/Types/Panel2.visible=false


func _on_150ml_water2_pressed():
	$AnimatedSprite.play("150water")
	$"../honey150".stop()
	$"../water150".play()
	$"../honey300".stop()
	$"../water300".stop()
	$Panel/Types/Panel2.visible=false

func _on_300ml_honey_pressed():
	$AnimatedSprite.play("300honey")
	$"../honey150".stop()
	$"../water150".stop()
	$"../honey300".play()
	$"../water300".stop()
	$Panel/Types/Panel2.visible=false

