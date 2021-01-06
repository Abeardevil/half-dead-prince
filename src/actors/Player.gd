extends Actor

class_name Player

export var boost_time = 1
export var boost_percent = 3000 #amount as percentage

var use_boost := false

func _physics_process(delta):
	_direction = calculate_direction()
	
	_velocity = calculate_movement_velocity()
	_velocity = move_and_slide(_velocity)
	
	var mousepos: Vector2 = get_global_mouse_position()
	var pos: Vector2 = get_position()	
	var delta_x = mousepos.x - pos.x
	var delta_y = pos.y - mousepos.y
	
	face_angle = atan2(delta_y, delta_x) * -1
	
	if Input.is_action_just_pressed("swap_realms"):
		$SpeedTimer.start(boost_time)
		use_boost = true
	
	if Input.is_action_just_pressed("equip"):
		pick_up_weapon(reachable_weapon)
	if Input.is_action_just_pressed("drop"):
		drop_weapon()

func calculate_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func calculate_movement_velocity() -> Vector2:
	var totalSpeed = speed * boost_percent / 100 if use_boost else speed
	return _direction * totalSpeed * get_physics_process_delta_time()

func _on_SpeedTimer_timeout():
	use_boost = false
	pass # Replace with function body.
