extends RigidBody2D

signal crystal_hit()

func _ready():
	self.collision_layer = get_node("../Background").collision_layer & 12
	connect("body_entered", self, "on_projectile_hit")

func on_projectile_hit(body: Node):
	if body.name == "Foreground":
		emit_signal("crystal_hit")
	$HitSoundEffect.play()
	explode()

func explode():
	$Sprite.visible = false
	$CollisionShape2D.visible = false
	$CPUParticles2D.emitting = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
