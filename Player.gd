extends KinematicBody2D

const SPEED = 100

var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
	else:
		velocity.x = 0
	
	move_and_slide(velocity)