extends Area2D

class_name Weapon

enum collision_enums {living_realm_collision = 16, spirit_realm_collision = 32,}
enum mask_enums {living_realm_mask = 16, spirit_realm_mask = 32,}

export var has_indicator = true
export var in_living_realm = true
export var angle_to_side : float = 0
export var weapon_angle : float
export var impact : float = 1

enum weaponTypes {SWORD, RANGED}

var realm_indicator : Realm_Indicator
var realm_indicator_scene : PackedScene = load('res://src/lights/Realm_Indicator.tscn')
var weaponType: int
var is_held : bool = false

const DEGREES_TO_RADIANS := PI / 180.0

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
	Globals.entity_display($".", !is_held || $AnimationPlayer.is_playing())

func _on_Weapon_body_entered(body : Node):
	if is_held:
		if body.name != get_parent().name:
			on_hit(body)
	else:
		body.set_reachable_weapon($'.')
	
func _on_Weapon_body_exited(body):
	if is_held:
#		if body.name != get_parent().name:
#			on_hit(body)
		pass
	else:
		if is_instance_valid(body.reachable_weapon) && body.reachable_weapon.name == $'.'.name:
			body.set_reachable_weapon(null)

func set_picked_up(new_owner):
	is_held = true
	in_living_realm = new_owner.in_living_realm
	realm_indicator.queue_free()
	set_collision_layer(0)
	set_collision_mask(0)
	
func set_put_down(prev_owner):
	is_held = false
	position = prev_owner.position
	in_living_realm = prev_owner.in_living_realm
	add_indicator()
	
func start_anim():
	pass
	
func on_hit(body):
	pass
