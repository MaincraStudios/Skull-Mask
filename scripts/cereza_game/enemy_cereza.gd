extends CharacterBody2D

@export var speed = 100
@onready var enemy = $"AnimatedSprite2D"

#Configuracion de aparicion de las bolas
@onready var timer = $Timer
@onready var ball_scene = preload("res://scenes/cereza_game/ball.tscn")

#Limites de pantalla
var left_limit = 9
var right_limit = 246
#Velocidad del enemigo
var enemy_speed = 200

#Tiempo para lanzar la bola en segundos
var time = 0.21
var ready_to_shoot = false

func _ready():
	#velocidad inicial, trigger para empezar el movimiento
	velocity = Vector2(speed,0)
	timer.wait_time = time
	update_animations("right")

func _physics_process(delta):
	var direction = "idle"

	#movement(direction)
	# Si la posicion global en x es menor a 300, se mueve a la derecha
	if global_position.x < left_limit:
		velocity = Vector2(enemy_speed,0)
		direction = "right"
		update_animations(direction)

	# Si la posicion global en x es mayor a 0, se mueve a la izquierda
	elif global_position.x > right_limit:
		velocity = Vector2(-enemy_speed,0)
		direction = "left"
		update_animations(direction)

	
	move_and_slide()

func update_animations(direction):
	if direction == "idle":
		enemy.play("idle")
	if direction == "front":
		enemy.play("move_front")
	if direction == "back":
		enemy.play("move_back")
	if direction == "right":
		enemy.play("move_right")
	if direction == "left":
		enemy.play("move_left")

func _on_timer_timeout():
	if ready_to_shoot == true:
		shoot()

func shoot():
	var ball_instance = ball_scene.instantiate()
	var ball_position = global_position
	ball_position.y = ball_position.y + 25
	ball_instance.global_position = ball_position
	get_parent().add_child(ball_instance)
	


func _on_scene_start_timeout():
	ready_to_shoot = true
