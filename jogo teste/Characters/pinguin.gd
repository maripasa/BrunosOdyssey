extends CharacterBody2D



#Varíaveis fisicas de velocidade e pulo.
const SPEED = 300.0
const JUMP_VELOCITY = -550.0
#Gravidade.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Estado natural no chão.
var is_jumping:= false
var is_falling:= false

#Declaração de animação para o personagem.
@onready var animation := $"Pinguint animation" as AnimatedSprite2D

func _physics_process(delta):
	# Adiciona a gravidade ao personagem caso não esteja no chão.
	if not is_on_floor():
		velocity.y += gravity * delta
		is_falling = true
	else:
		is_falling = false
		
		
	# Faz o personagem pular.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Adiciona a movimentação de esquerda e direita ao personagem. 
	#LEMBRAR DE ALTERAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#Caso haja um direcionamento, o personagem irá se mover
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if is_on_floor_only():
			animation.play("Run")
	elif is_jumping:
			animation.play("Jump")
		
		
		#Caso não haja, irá ficar parado.
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("Idle")

	move_and_slide()
