extends Area2D

class_name Weapon

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
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Weapon_body_entered(body):
	if isHeld:
		pass
	else:
		body.set_reachable_weapon($'.')
	
func _on_Weapon_body_exited(body):
	if isHeld:
		pass
	else:
		if body.reachable_weapon.name == $'.'.name:
			body.set_reachable_weapon(null)
