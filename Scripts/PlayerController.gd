extends KinematicBody2D

var SPEED = 16.0 * 8 # 8 tiles per second
var BULLET_SPEED = 16.0 * 12 # 12 tiles per second

var projectile_scene = load("res://Scenes/Projectile.tscn")

var last_velocity = Vector2.DOWN

func _ready():
	get_current_world().get_node("MusicPlayer").play()
	$AnimatedSprite.playing = true

func is_empty_area(tilemap: TileMap):
	var cell = tilemap.world_to_map(position)
	var tile = tilemap.get_cellv(cell)
	return tile == -1

func swap_world_if_possible():
	if not is_empty_area(get_node("../BlueWorld/Background")):
		if not is_empty_area(get_node("../RedWorld/Background")):
			var previous_world = get_current_world()
			swap_color()
			if test_move(transform, Vector2.ZERO):
				swap_color()
			else:
				previous_world.get_node("MusicPlayer").pause()
				get_current_world().get_node("MusicPlayer").resume()
				$CPUParticles2D.color = $AnimatedSprite.modulate
				$CPUParticles2D.restart()
				$CPUParticles2D.emitting = true
				$ChangeWorldSoundEffect.play()

func swap_color():
	if collision_layer == 1:
		$AnimatedSprite.modulate = Color.red
		collision_layer = 2
		collision_mask = 2
	else:
		$AnimatedSprite.modulate = Color.blue
		collision_layer = 1
		collision_mask = 1

func update_animation(velocity, type):
	if velocity.x < 0:
		$AnimatedSprite.animation = "left_" + type
	elif velocity.x > 0:
		$AnimatedSprite.animation = "right_" + type
	elif velocity.y < 0:
		$AnimatedSprite.animation = "up_" + type
	elif velocity.y > 0:
		$AnimatedSprite.animation = "down_" + type

func get_current_world():
	if collision_layer == 1:
		return get_node("../BlueWorld")
	else:
		return get_node("../RedWorld")

func create_projectile():
	var projectile: RigidBody2D = projectile_scene.instance()
	projectile.linear_velocity = last_velocity * BULLET_SPEED
	projectile.position = position + last_velocity * 8
	projectile.connect("crystal_hit", self, "swap_world_if_possible")
	get_current_world().add_child(projectile)
	$ShotSoundEffect.play()

func _physics_process(_delta):
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
		update_animation(velocity, "walk")
		move_and_slide(velocity.normalized() * SPEED)
	else:
		update_animation(last_velocity, "idle")
