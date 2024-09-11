extends Control

var paused: bool = false
@export_category("Objects")
@export var _pause_menu: PauseMenu

@onready var player: AnimatedSprite2D = $player
var current_size = size
func _ready():
	sound_fx.level_3_music.player("play")
	# Esconde os painéis no início da luta
	$Textbox.hide()
	$ActionsPanel.hide()
	
	# Mostra a caixa de texto inicial da batalha
	display_text("O Reisqueleto aparece para te confrontar!")
	$player.play("Player_idle")
	$Enemy.play("Enemy_idle")
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()

func pause_menu() -> void:
	if paused:
		sound_fx.level_3_music.volume_db += 15
		_pause_menu.hide()
		Engine.time_scale = 1
	else:
		sound_fx.level_3_music.volume_db -= 15
		_pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func _input(event): 
	# Permite a interação do usuário com a caixa de texto
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
	# Esconde a caixa de texto após a intereação do usuário
		$Textbox.hide()
		emit_signal("Textbox_closed")
		$ActionsPanel.show()
	
func display_text(text):
	#vai mostrar o texto da caixa de texto
	$Textbox.show()
	$Textbox/Label.text = text
	
func enemy_turn():
	await get_tree().create_timer(1).timeout
	display_text("O Reisqueleto o golpeia com seu poderoso osso!")
	$Enemy.play("Boneshock")
	$Textbox.hide()
	
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("Player_damaged")
	$player.play("Player_hurt")
	
	$CanvasLayer/Design/PHbar.size.x -= 22
	if $CanvasLayer/Design/PHbar.size.x <= 0:
		display_text("O Reisqueleto lhe subjulgou em batalha!")
	
		await get_tree().create_timer(1).timeout
		display_text("Voce foi derrotado!")
		await get_tree().create_timer(1).timeout
		$player.play("Fainted")
		$Textbox.hide()
		await get_tree().create_timer(2).timeout
		transition_screen.fade_in("res://interface/ending_screen/ending_screen.tscn")
		
	elif $CanvasLayer/Design/PHbar.size.x > 0:
		await get_tree().create_timer(1).timeout
		display_text("Voce foi golpeado fortemente!")
		$Enemy.play("Enemy_idle")
		$player.play("Player_idle")
		await get_tree().create_timer(1).timeout
		$Textbox.hide()
		$ActionsPanel.show()
	
func _on_run_pressed():
	# Interação caso escolha a opção de fugir contra o chefe
	$ActionsPanel.hide()
	display_text("O Reisqueleto te impede de fugir!")
	
func _on_attack_pressed():
	$ActionsPanel.hide()
	display_text("Voce arremessa uma bola de neve no inimigo")

	await get_tree().create_timer(1).timeout
	$Textbox.hide()
	$player.play("Throw")
	await get_tree().create_timer(1).timeout
	display_text("Voce o acerta em cheio!") 
	$player.play("Player_idle")
	
	$AnimationPlayer.play("Enemy_damaged")
	$Enemy.play("Enemy_hurt")
	$CanvasLayer/Design2/EHbar.size.x -= 30
	if $CanvasLayer/Design2/EHbar.size.x == 0:
		$Enemy.play("Bones")
		
		await get_tree().create_timer(1).timeout
		display_text("O Reisqueleto foi derrotado! Voce venceu!")
		$Textbox.hide()
		$player.play("Win")
		
		display_text("Congratulations!")
		await get_tree().create_timer(1).timeout
		$Textbox.hide()
		
		await get_tree().create_timer(3).timeout
		transition_screen.fade_in("res://interface/ending_screen/ending_screen.tscn")
	
	await get_tree().create_timer(1).timeout
	
	emit_signal("enemy_stats_changed", self)
	await $AnimationPlayer.animation_finished
	
	enemy_turn()
	
func _on_defend_pressed():
	$ActionsPanel.hide()
	display_text("Voce se prepara para desviar do golpe!")
	await get_tree().create_timer(1).timeout
	display_text("O Reisqueleto o golpeia com seu poderoso osso!")
	await get_tree().create_timer(1).timeout
	$Textbox.hide()
	$Enemy.play("Boneshock")
	await get_tree().create_timer(1).timeout
	$player.play("Dodge")
	await get_tree().create_timer(1).timeout
	display_text("Voce esquiva com sucesso!")
	$Enemy.play("Enemy_idle")
	await get_tree().create_timer(1).timeout
	$player.play("Player_idle")
	
	$Textbox.hide()
	$ActionsPanel.show()
	
