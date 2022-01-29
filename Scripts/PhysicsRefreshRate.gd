extends Node

var next_update = 2.0
var refresh_rate = 60

func _process(delta):
	next_update -= delta
	if next_update < 0:
		next_update = 2.0
		var fps = Performance.get_monitor(Performance.TIME_FPS)
		if fps != refresh_rate and fps > 1:
			refresh_rate = fps
			Engine.set_iterations_per_second(refresh_rate)
			print("Switched to " + str(refresh_rate) + " hz")
