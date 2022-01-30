extends StaticBody2D

export(Texture) var OpenTexture
export(Texture) var ClosedTexture

export(Array, String) var LinkedEnemies

onready var player: KinematicBody2D = get_node("/root/MainScene/Player")

var killed_enemies = 0

func _ready():
	$Sprite.texture = ClosedTexture
	self.collision_layer = get_node("../Background").collision_layer
	self.collision_mask = get_node("../Background").collision_mask
	for name in LinkedEnemies:
		get_node("../" + name).connect("died", self, "enemy_died")

func enemy_died():
	killed_enemies += 1
	if killed_enemies >= len(LinkedEnemies):
		open()

func open():
	$CollisionPolygon2D.set_deferred("disabled", true)
	$Sprite.texture = OpenTexture

func _process(_delta):
	if player.global_position.y < global_position.y:
		z_index = 8
	else:
		z_index = 1
