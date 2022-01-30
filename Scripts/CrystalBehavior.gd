extends StaticBody2D

func _ready():
	self.collision_layer = get_node("../Background").collision_layer
	self.collision_mask = get_node("../Background").collision_mask
