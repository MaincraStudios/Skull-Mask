extends CharacterBody2D


@onready var player = $"AnimatedSprite2D"

#limites de movimiento
var allow_movement = false
var left_limit = 9
var right_limit = 246
var top_limit = -380
var bottom_limit = 139
var player_speed = 70
var initial_position_player = Vector2(128,126)

func _physics_process(delta):
	#velocity = Vector2(speed,0)
	#move_and_slide()
	velocity = Vector2(0,0)
	var direction = "idle"
	if allow_movement ==true:
		if Input.is_action_pressed("move_up") and global_position.y > top_limit:
			velocity = Vector2(0,-player_speed)
			direction = "back"
		if Input.is_action_pressed("move_down") and global_position.y < bottom_limit:
			velocity = Vector2(0,player_speed)
			direction = "front"
		if Input.is_action_pressed("move_right") and global_position.x < right_limit:
			velocity = Vector2(player_speed,0)
			direction = "right"
		if Input.is_action_pressed("move_left") and global_position.x > left_limit:
			velocity = Vector2(-player_speed,0)
			direction = "left"
		
	#if global_position.y == -380:
	if global_position.y <= -380:
		get_tree().change_scene_to_file("res://scenes/cereza_game/cereza_end_message.tscn")
		
	move_and_slide()
	#var size =  get_viewport_rect().size
	# Cuarta forma
	#global_position = global_position.clamp(Vector2(0,0),size) 
	update_animations(direction)
	
func update_animations(direction):
	if direction == "idle":
		player.play("idle")
	if direction == "front":
		player.play("move_front")
	if direction == "back":
		player.play("move_back")
	if direction == "right":
		player.play("move_right")
	if direction == "left":
		player.play("move_left")

func reset_position():
	global_position = initial_position_player


func _on_timer_timeout():
	#despues de 10 segundos inicia el juego
	allow_movement=true
