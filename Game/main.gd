extends Node2D

var cur_subseq = [] #Текущая правильная последовательность
var player_subseq = [] #Последовательность, котоурю успел сыграть игрок
var plaing_flag = false
var score = 0 #Счет игрока
var score_step = 100 #По скольку будет получать игрок, за правильное нажатие
var round_number = 1 
var coins = 0

var able_to_play = true #Флаг который показывает, можно ли играть следующую ноту
var note_count = 0 #Счетчик сыгранных нот
var fail = false #Флаг, который показывает, совершена ли ошибка



func _ready():
	pass


func _process(delta):
	$Score.text = "SCORE:" + str(score)
	$Round_text.text = "ROUND:" + str(round_number)
	$RestartPanel/ScoreResult.text = "Your score: " + str(score)
	$RestartPanel/Reward.text = "Coins: " + str(int(score*0.3))
	if note_count < cur_subseq.size() and plaing_flag == true:
		if able_to_play:
			play_note(cur_subseq[note_count])
			note_count += 1
			if note_count >= cur_subseq.size():
				plaing_flag = false
			able_to_play = false
			$Timer.start(1)
	if player_subseq.size() >= cur_subseq.size() and cur_subseq.size() != 0:
		new_round()
		able_to_play = false
		$Timer.start(3)
		
	if fail:
			$AudioStreamPlayer2D.stop()
			$NoteBlue.visible = false
			$NoteOrange.visible = false
			$NotePurple.visible = false
			$NotePurpleAnim.visible = false
			$NoteOrangeAnim.visible = false
			$NoteBlueAnim.visible = false
			$NotePurpleAnim.stop()
			$NoteOrangeAnim.stop()
			$NoteBlueAnim.stop()
			$Score.visible = false
			$Round_text.visible = false
			$RestartPanel.visible = true
	



#Генератор новой ноты(члена последовательности)
var rng = RandomNumberGenerator.new()
func gen_new_note():
	rng.randomize()
	cur_subseq.append(rng.randi_range(0, 2))

#Сравнение последней нажатой кнопки и члена правльной последовательности
func check():
	if cur_subseq.size() < player_subseq.size():
		return false
	if player_subseq[player_subseq.size() - 1] == cur_subseq[player_subseq.size() - 1]:
		score += score_step
		return true
	else:
		return false
		

#Фун-ии загрузки и воиспроизведения нот 
func play_do():
	$AudioStreamPlayer2D.stream = load("res://Game/assets/music/do.mp3")
	$AudioStreamPlayer2D.play()
func play_mi():
	$AudioStreamPlayer2D.stream = load("res://Game/assets/music/mi.mp3")
	$AudioStreamPlayer2D.play()
func play_sol():
	$AudioStreamPlayer2D.stream = load("res://Game/assets/music/sol.mp3")
	$AudioStreamPlayer2D.play()
	
func play_note(num):
	if num == 0:
		play_do()
		$NoteBlue.visible = true
		$NoteBlueAnim.visible = true
		$NoteBlueAnim.play()
	elif num == 1:
		play_mi()
		$NoteOrange.visible = true
		$NoteOrangeAnim.visible = true
		$NoteOrangeAnim.play()
	elif num == 2:
		play_sol()
		$NotePurple.visible = true
		$NotePurpleAnim.visible = true
		$NotePurpleAnim.play()
	else:
		print("SOME SHIT HAPPENED!!!")
	

func _on_AudioStreamPlayer2D_finished():
	#print("Audio end!!!")
	pass


func _on_TextureButton_pressed():
	play_do()
	player_subseq.append(0)
	$Timer.start(0.5)
	$NoteBlue.visible = true
	$NoteBlueAnim.visible = true
	$NoteBlueAnim.play()
	if !(check()):
		coins += score*0.3
		fail = true
	#print(player_subseq)
	#print(check())

func _on_TextureButton2_pressed():
	play_mi()
	player_subseq.append(1)
	$Timer.start(0.5)
	$NoteOrange.visible = true
	$NoteOrangeAnim.visible = true
	$NoteOrangeAnim.play()
	if !(check()):
		coins += score*0.3
		fail = true
	#print(player_subseq)
	#print(check())
func _on_TextureButton3_pressed():
	play_sol()
	player_subseq.append(2)
	$Timer.start(0.5)
	$NotePurple.visible = true
	$NotePurpleAnim.visible = true
	$NotePurpleAnim.play()
	if !(check()):
		coins += score*0.3
		fail = true
	#print(player_subseq)
	#print(check())



func _on_Timer_timeout():
	able_to_play = true
	$WaitPanel.visible = false
	$NoteBlue.visible = false
	$NoteBlueAnim.visible = false
	$NoteBlueAnim.stop()
	$NoteOrange.visible = false
	$NotePurple.visible = false
	$NoteOrangeAnim.visible = false
	$NoteOrangeAnim.stop()
	$NotePurpleAnim.visible = false
	$NotePurpleAnim.stop()


func _on_StartButton_pressed():
	for i in range(3):
		gen_new_note()
	print("Start qur_subseq:", cur_subseq)
	$StartPanel.visible = false
	$Score.visible = true
	$Round_text.visible = true
	plaing_flag = true


func new_round():
	gen_new_note()
	round_number += 1
	score_step = score_step * 1.2
	print("qur_subseq:", cur_subseq)
	note_count = 0
	player_subseq = []
	plaing_flag = true
	$WaitPanel.visible = true




func _on_RestartButton_pressed():
	cur_subseq = []
	player_subseq = []
	note_count = 0
	score = 0
	
	score_step = 100
	round_number = 1
	fail = false
	for i in range(3):
		gen_new_note()
	print("Recreated qur_subseq:",cur_subseq)
	plaing_flag = true
	$RestartPanel.visible = false
	$Score.visible = true
	$Round_text.visible = true

func _on_TestButton_pressed():
	pass



var file = File.new()
func _on_ExitButton_pressed():
	file.open("user://Goldcount.txt", file.READ)
	var gold_count = file.get_line().to_int()
	var player_name = file.get_line()
	file.close()
	gold_count = gold_count + coins
	if fail == false:
		gold_count = gold_count + score*0.3
	file.open("user://Goldcount.txt", file.WRITE)
	file.store_line(str(gold_count))
	file.store_line(player_name)
	file.close()
	get_tree().change_scene("res://MainScen.tscn")
