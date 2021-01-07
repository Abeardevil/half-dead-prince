extends Area2D

class_name Weapon

enum collision_enums {living_realm_collision = 16, spirit_realm_collision = 32,}
enum mask_enums {living_realm_mask = 24, spirit_realm_mask = 40,}

export var has_indicator = true
export var in_living_realm = true
export var angle_to_side : float = 0
export var weapon_angle : float

enum weaponTypes {SWORD, RANGED}
enum weaponStates {IDLE, ATTACK}
var swing_arc := 45 * DEGREES_TO_RADIANS

var realm_indicator : Realm_Indicator
var realm_indicator_scene : PackedScene = load('res://src/lights/Realm_Indicator.tscn')
var weaponOwner: WeakRef
var weaponType: int
var is_held : bool = false

const DEGREES_TO_RADIANS := PI/180.0

var draw_radius := 20
var sword_angle := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_angle = angle_to_side
	if has_indicator:
		add_indicator()

func add_indicator():
	realm_indicator = realm_indicator_scene.instance()
	add_child(realm_indicator)
	
func _process(delta):
	var current_collision = get_collision_layer()
	var current_mask = get_collision_mask()
	if in_living_realm:
		if !is_held:
			var living_realm_shown = get_parent().living_realm_shown
			realm_indicator.set_living_glow_vis(!living_realm_shown)
		if current_collision != collision_enums.living_realm_collision:
			set_collision_layer(collision_enums.living_realm_collision)
		if current_mask != mask_enums.living_realm_mask:
			set_collision_mask(mask_enums.living_realm_mask)
	else:
		if !is_held:
			var living_realm_shown = get_parent().living_realm_shown
			realm_indicator.set_spirit_glow_vis(living_realm_shown)
		if current_collision != collision_enums.spirit_realm_collision:
			set_collision_layer(collision_enums.spirit_realm_collision)
		if current_mask != mask_enums.spirit_realm_mask:
			set_collision_mask(mask_enums.spirit_realm_mask)


func _on_Weapon_body_entered(body : Node):
	if is_held:
		if body.name != get_parent().name:
			body.get_parent().remove_child(body)
		pass
	else:
		body.set_reachable_weapon($'.')
	
func _on_Weapon_body_exited(body):
	if is_held:
		pass
	else:
		if is_instance_valid(body.reachable_weapon) && body.reachable_weapon.name == $'.'.name:
			body.set_reachable_weapon(null)

func set_picked_up(new_owner):
	is_held = true
	in_living_realm = new_owner.in_living_realm
	remove_child(realm_indicator)
	
func set_put_down(prev_owner):
	is_held = false
	position = prev_owner.position
	in_living_realm = prev_owner.in_living_realm
	add_indicator()
	
func start_anim():
	pass
