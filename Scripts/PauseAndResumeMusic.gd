extends AudioStreamPlayer

var position: float = 0.0

func pause():
	position = get_playback_position()
	stop()

func resume():
	play(position)
