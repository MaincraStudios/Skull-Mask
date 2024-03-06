extends Area2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var ball_speed = 150
var bottom_limit = 139

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var velocity = Vector2(0,0)

func _physics_process(delta):
	global_position.y += ball_speed*delta 
	if global_position.y > bottom_limit:
		die()

func _on_body_entered(body):
	body.reset_position()
	die()
	
func die():
	queue_free()
