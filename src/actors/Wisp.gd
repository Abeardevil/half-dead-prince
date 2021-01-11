extends Enemy

class_name Wisp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	attack()
	pass

func _physics_process(delta):
	var normalized_face_rads = face_angle
	while(normalized_face_rads > 7 * PI / 4 || normalized_face_rads < -PI / 2):
		if normalized_face_rads > 7 * PI / 4:
			normalized_face_rads -= 2 * PI
		else:
			normalized_face_rads += 2 * PI
	
	for i in range(4):
		var fov_center = i * PI / 2
		var fov_half = PI / 4
		if normalized_face_rads < fov_center + fov_half && normalized_face_rads > fov_center - fov_half:
			if i == 0:
				$Sprite.frame = 2
			elif i == 1:
				$Sprite.frame = 0
			elif i == 2:
				$Sprite.frame = 3
			elif i == 3:
				$Sprite.frame = 1
		pass
	pass
	
func take_damage():
	print(heart_cnt)
	heart_cnt -= 1
	if heart_cnt <= 0:
		Globals.player_score += 1
		Globals.spawn_new_wisp()
		if is_instance_valid($AnimationPlayer):
			$AnimationPlayer.play("Death Poof")
			yield($AnimationPlayer, "animation_finished")
		queue_free()
	pass
