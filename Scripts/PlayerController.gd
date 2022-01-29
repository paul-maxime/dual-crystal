extends KinematicBody2D

var SPEED = 100.0

func swap_color():
	if collision_layer == 1:
		$AnimatedSprite.modulate = Color.red
		collision_layer = 2
		collision_mask = 2
	else:
		$AnimatedSprite.modulate = Color.blue
		collision_layer = 1
		collision_mask = 1

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		swap_color()

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.animation = "down_idle"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.animation = "up_idle"
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.animation = "right_idle"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.animation = "left_idle"

	move_and_slide(velocity.normalized() * SPEED)
