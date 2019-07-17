extends KinematicBody2D

const SPEED = 100
const FLOOR = Vector2(0, -1)
const GRAVITY = 970

var velocity = Vector2()
var direction = 1
var is_alive = true

func kill():
	is_alive = false
	velocity.x = 0
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$DeadCollision.disabled = false

func _physics_process(delta):
	if is_alive == true:
		velocity.x = SPEED * direction
		$AnimatedSprite.play("walk")
	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		change_direction()
	
func change_direction():
	direction *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h