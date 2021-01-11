extends Sprite

class_name Heart

var is_filled = true

func _process(delta):
	if is_filled && frame != 0:
		frame = 0
	elif !is_filled && frame != 1:
		frame = 1
	pass
