extends KinematicBody2D

const SPEED = 200
const FLOOR = Vector2(0, -1)
const GRAVITY = 970
const JUMP_POWER = 500

var velocity = Vector2()

func _physics_process(delta):
	if position.y > 800:
		position.y = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y = -JUMP_POWER
	
	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)