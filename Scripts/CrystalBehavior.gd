extends StaticBody2D

func _ready():
	self.collision_layer = get_node("../Background").collision_layer
	self.collision_mask = get_node("../Background").collision_mask

func hit():
	$Tween.interpolate_property($Sprite, "modulate", Color(1.0, 1.0, 1.0), Color(1.5, 1.5, 1.5), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.interpolate_property($Sprite, "modulate", Color(1.5, 1.5, 1.5), Color(1.0, 1.0, 1.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	$CrystalSoundEffect.play()
