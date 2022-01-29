extends RigidBody2D

signal crystal_hit()

func _ready():
	self.collision_layer = get_node("../Background").collision_layer & 12
	connect("body_entered", self, "on_projectile_hit")

func on_projectile_hit(body: Node):
	if body.name == "Foreground":
		emit_signal("crystal_hit")
	queue_free()
