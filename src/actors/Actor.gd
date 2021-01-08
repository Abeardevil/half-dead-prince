extends KinematicBody2D

class_name Actor

enum collision_enums {living_realm_collision = 16, spirit_realm_collision = 32,}
enum mask_enums {living_realm_mask = 24, spirit_realm_mask = 40,}

export var speed := 3000.0
export var friction := 800
export var equipped_weapon : PackedScene
export var arm_length := 0
export var in_living_realm = true
export var has_indicator = true

var realm_indicator : Realm_Indicator
var realm_indicator_scene : PackedScene = load('res://src/lights/Realm_Indicator.tscn')
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
	point_weapon()
	var current_collision = get_collision_layer()
	var current_mask = get_collision_mask()
	var living_realm_shown = get_parent().living_realm_shown
	if in_living_realm:
		if is_instance_valid(realm_indicator):
			realm_indicator.set_living_glow_vis(!living_realm_shown)
		if current_collision != collision_enums.living_realm_collision:
			set_collision_layer(collision_enums.living_realm_collision)
		if current_mask != mask_enums.living_realm_mask:
			set_collision_mask(mask_enums.living_realm_mask)
	else:
		if is_instance_valid(realm_indicator):
			realm_indicator.set_spirit_glow_vis(living_realm_shown)
		if current_collision != collision_enums.spirit_realm_collision:
			set_collision_layer(collision_enums.spirit_realm_collision)
		if current_mask != mask_enums.spirit_realm_mask:
			set_collision_mask(mask_enums.spirit_realm_mask)

func add_indicator():
	realm_indicator = realm_indicator_scene.instance()
	add_child(realm_indicator)

func get_velocity() -> Vector2:
	return _velocity

func point_weapon():
	if is_instance_valid(current_weapon):
		var finalPos := Vector2.ZERO
		var weapon_rotation = face_angle + (current_weapon.weapon_angle) * PI / 180
		finalPos.x = cos(weapon_rotation) * arm_length
		finalPos.y = sin(weapon_rotation) * arm_length
		current_weapon.set_position(finalPos)
		current_weapon.rotation = weapon_rotation

func pick_up_weapon(new_weapon : Weapon):
	if new_weapon != null:
	  drop_weapon()
	  current_weapon = transfer_instance(new_weapon, $'.')
	  current_weapon.set_picked_up($".")
	  # current_weapon.isHeld = true
	  # current_weapon.in_living_realm = in_living_realm
	  new_weapon.queue_free()
	
func drop_weapon():
	if current_weapon != null:
		var ground = get_parent()
		var old_weapon : Weapon = transfer_instance(current_weapon, ground)
		old_weapon.set_put_down($".")
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
		
func attack():
	if is_instance_valid(current_weapon):
		current_weapon.start_anim()

		
func do_shift():
	in_living_realm = !in_living_realm
	if current_weapon != null:
		current_weapon.in_living_realm = in_living_realm
