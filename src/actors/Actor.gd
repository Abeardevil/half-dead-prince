extends KinematicBody2D

class_name Actor

export var speed := 3000.0
export var friction := 800
export var equipped_weapon : PackedScene
export var arm_length := 0
export var in_living_realm = true
export var has_indicator = true

var realm_indicator : Realm_Indicator
var realm_indicator_scene : PackedScene = load('res://src/lights/Realm_Indicator.tscn')
var is_glowing = false
var _velocity := Vector2.ZERO
var _direction := Vector2.ZERO
var face_angle : float = 0
var current_weapon : Weapon
var reachable_weapon : Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_indicator:
		add_indicator()
	if equipped_weapon != null && equipped_weapon.can_instance():
		pick_up_weapon(equipped_weapon.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_weapon_position()
	pass

func add_indicator():
	realm_indicator = realm_indicator_scene.instance()
	add_child(realm_indicator)
	
	if !in_living_realm:
		_toggle_indicator()
		
	if is_instance_valid(get_parent()):
		get_parent().connect('shift_toggle', $'.', "_toggle_indicator")

func _toggle_indicator():
	is_glowing = !is_glowing
	if(is_glowing):
		if in_living_realm:
			realm_indicator.set_living_glow_vis(true)
		else:
			realm_indicator.set_spirit_glow_vis(true)
	else:
		if in_living_realm:
			realm_indicator.set_living_glow_vis(false)
		else:
			realm_indicator.set_spirit_glow_vis(false)

func get_velocity() -> Vector2:
	return _velocity

func calculate_weapon_position():
	if !is_instance_valid(current_weapon):
		return
	point_weapon_by_angle(face_angle)
	
func point_weapon_by_angle(angle: float):
	current_weapon.rotation = angle
	var finalPos := Vector2.ZERO
	finalPos.x = cos(angle) * arm_length
	finalPos.y = sin(angle) * arm_length
	current_weapon.set_position(finalPos)

func pick_up_weapon(new_weapon : Weapon):
	if new_weapon != null:
		drop_weapon()
		current_weapon = transfer_instance(new_weapon, $'.')
		current_weapon.isHeld = true
		new_weapon.queue_free()
	
func drop_weapon():
	if current_weapon != null:
		var ground = get_parent()
		var old_weapon : Weapon = transfer_instance(current_weapon, ground)
		old_weapon.isHeld = false
		old_weapon.position = position
		current_weapon.queue_free()
	
func set_reachable_weapon(new_reachable_weapon : Weapon):
	reachable_weapon = new_reachable_weapon

func transfer_instance(instance : Node, new_parent : Node) -> Node:
	var new_scene : PackedScene = PackedScene.new()
	var result = new_scene.pack(instance)
	if result == OK:
		var new_instance = new_scene.instance()
		new_parent.add_child(new_instance)
		return new_instance
	else:
		push_error("An error occured while transfering")
		return null
		
