extends KinematicBody2D

const VISION_RANGE = 16.0 * 8;
const SPEED = 16.0 * 6;

onready var player: KinematicBody2D = get_node("/root/MainScene/Player")

func _ready():
	self.collision_layer = get_node("../Background").collision_layer
	self.collision_mask = get_node("../Background").collision_mask

func _physics_process(delta):
	var distance = global_position.distance_to(player.global_position)
	var direction = global_position.direction_to(player.global_position)
	if distance <= VISION_RANGE and player.collision_layer & self.collision_layer:
		move_and_collide(direction * SPEED * delta)
