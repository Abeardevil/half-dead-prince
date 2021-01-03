extends Actor

func _physics_process(delta):
	_direction = calculate_direction()
	
	_velocity = calculate_movement_velocity()
	_velocity = move_and_slide(_velocity)

func calculate_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func calculate_movement_velocity() -> Vector2:
	return _direction * speed * get_physics_process_delta_time()
