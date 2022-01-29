extends Camera2D

func _ready():
	get_tree().get_root().connect("size_changed", self, "on_size_changed")
	on_size_changed()

func on_size_changed():
	var size = get_viewport_rect().size
	var smallest_size = min(size.x / 1024, size.y / 600)
	var scale = 1.0
	if smallest_size > 1.5:
		scale = 4.0
	elif smallest_size > 1.2:
		scale = 3.0
	elif smallest_size > 0.6:
		scale = 2.0
	zoom = Vector2(1.0 / scale, 1.0 / scale)
