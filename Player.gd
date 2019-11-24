extends KinematicBody2D

const SPEED = 200
const FLOOR = Vector2(0, -1)
const GRAVITY = 970
const JUMP_POWER = 550
const PLASMA = preload("res://Plasma.tscn")

var is_firing = false
var is_dead = false
var velocity = Vector2()

var coins = 0

func add_coin():
	coins += 1

func die():
	$AnimatedSprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
	is_dead = true

func _physics_process(delta):
	if is_dead:
		return
	if position.y > 800:
		position.y = 0
	if is_firing == true:
		return
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = abs($Position2D.position.x)
		if is_on_floor():
			$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = abs($Position2D.position.x) * -1
		if is_on_floor():
			$AnimatedSprite.play("walk")
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite.play("idle")

	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y = -JUMP_POWER
		$AnimatedSprite.play("jump")

	if Input.is_action_just_pressed("ui_accept") && is_firing == false && is_on_floor():
		is_firing = true
		$AnimatedSprite.play("fire")

	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "fire":
		var plasma = PLASMA.instance()
		plasma.direction = sign($Position2D.position.x)
		plasma.position = $Position2D.global_position
		get_parent().add_child(plasma)
		is_firing = false
