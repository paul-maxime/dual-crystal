extends KinematicBody2D

var SPEED = 16.0 * 8 # 8 tiles per second
var BULLET_SPEED = 16.0 * 12 # 12 tiles per second

var projectile_scene = load("res://Scenes/Projectile.tscn")

var last_velocity = Vector2.DOWN

func is_empty_area(tilemap: TileMap):
	var cell = tilemap.world_to_map(position)
	var tile = tilemap.get_cellv(cell)
	return tile == -1

func swap_world_if_possible():
	if not is_empty_area(get_node("../BlueWorld/Background")):
		if not is_empty_area(get_node("../RedWorld/Background")):
			swap_color()
			if test_move(transform, Vector2.ZERO):
				swap_color()

func swap_color():
	if collision_layer == 1:
		$AnimatedSprite.modulate = Color.red
		collision_layer = 2
		collision_mask = 2
	else:
		$AnimatedSprite.modulate = Color.blue
		collision_layer = 1
		collision_mask = 1

func update_animation(velocity):
	if velocity.y < 0:
		$AnimatedSprite.animation = "up_idle"
	if velocity.y > 0:
		$AnimatedSprite.animation = "down_idle"
	if velocity.x < 0:
		$AnimatedSprite.animation = "left_idle"
	if velocity.x > 0:
		$AnimatedSprite.animation = "right_idle"

func get_current_world():
	if collision_layer == 1:
		return get_node("../BlueWorld")
	else:
		return get_node("../RedWorld")

func create_projectile():
	var projectile: RigidBody2D = projectile_scene.instance()
	projectile.linear_velocity = last_velocity * BULLET_SPEED
	projectile.position = position
	projectile.connect("crystal_hit", self, "swap_world_if_possible")
	get_current_world().add_child(projectile)

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		create_projectile()

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1

	if velocity != Vector2.ZERO:
		last_velocity = velocity.normalized()
		update_animation(velocity)
		move_and_slide(velocity.normalized() * SPEED)
