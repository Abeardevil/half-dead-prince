extends Actor

class_name Player

export var boost_time = 1
export var boost_percent = 300 #amount as percentage
export var zoom_amount = 0.1
export var min_zoom = 0.1

signal player_shifting

var use_boost := false

func _ready():
	pass

func _process(delta):
	handle_camera_zoom()
	Globals.player_health = heart_cnt

func _physics_process(delta):
	_direction = calculate_direction()
	_velocity = calculate_movement_velocity()
	_velocity = move_and_slide(_velocity * delta * 100)
	
	var mousepos: Vector2 = get_global_mouse_position()
	var pos: Vector2 = get_position()
	var delta_x = mousepos.x - pos.x
	var delta_y = mousepos.y - pos.y
	
	face_angle = atan2(delta_y, delta_x)
	if Input.is_action_just_pressed("swap_realms"):
		do_shift()
		$SpeedTimer.start(boost_time)
		use_boost = true
#		living_realm_shown = !living_realm_shown
		Globals.living_realm_shown = !Globals.living_realm_shown
	
	if Input.is_action_just_pressed("equip"):
		pick_up_weapon(reachable_weapon)
	if Input.is_action_just_pressed("drop"):
		drop_weapon()
	if Input.is_action_just_pressed("attack"):
		attack()

func calculate_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()

func calculate_movement_velocity() -> Vector2:
	var totalSpeed = speed * boost_percent / 100 if use_boost else speed
	return _direction * totalSpeed * get_physics_process_delta_time()

func _on_SpeedTimer_timeout():
	use_boost = false
	pass # Replace with function body.

func handle_camera_zoom():
	if Input.is_action_just_released("zoom_in"):
		$Camera2D.zoom.x -= zoom_amount
		$Camera2D.zoom.y -= zoom_amount
		if $Camera2D.zoom.x < min_zoom:
			$Camera2D.zoom.x = min_zoom
		if $Camera2D.zoom.y < min_zoom:
			$Camera2D.zoom.y = min_zoom
	if Input.is_action_just_released("zoom_out"):
		$Camera2D.zoom.x += zoom_amount
		$Camera2D.zoom.y += zoom_amount

func _exit_tree():
	Globals.game_running = false
