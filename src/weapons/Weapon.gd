extends Area2D

class_name Weapon

export var has_indicator = true
export var in_living_realm = true

var realm_indicator : Realm_Indicator
var realm_indicator_scene : PackedScene = load('res://src/lights/Realm_Indicator.tscn')
var is_glowing = false

enum weaponTypes {SWORD, RANGED}
enum weaponStates {IDLE, ATTACK}
var swing_arc := 45 * DEGREES_TO_RADIANS

var weaponOwner: WeakRef
var weaponType: int
var isHeld : bool = false

const DEGREES_TO_RADIANS := PI/180.0

var draw_radius := 20
var sword_angle := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_indicator:
		add_indicator()

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

func _on_Weapon_body_entered(body):
	if isHeld:
		pass
	else:
		body.set_reachable_weapon($'.')
	
func _on_Weapon_body_exited(body):
	if isHeld:
		pass
	else:
		if is_instance_valid(body.reachable_weapon) && body.reachable_weapon.name == $'.'.name:
			body.set_reachable_weapon(null)
