extends Area2D

class_name Weapon

enum weaponTypes {SWORD, RANGED}
enum weaponStates {IDLE, ATTACK}
var swing_arc := 45 * DEGREES_TO_RADIANS

var weaponOwner: WeakRef
var weaponType: int

const DEGREES_TO_RADIANS := PI/180.0

var draw_radius := 20
var sword_angle := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_weapon_position()

func point_weapon_by_angle(angle: float):
	if !is_instance_valid(weaponOwner):
		return
		
	var pos: Vector2 = weaponOwner.get_ref().get_position()
		
	rotation = angle
	
	var finalPos := Vector2.ZERO
	
	finalPos.x = pos.x + cos(rotation)*draw_radius
	finalPos.y = pos.y + sin(rotation)*draw_radius
	
	set_position(finalPos)

func calculate_weapon_position():
	if !is_instance_valid(weaponOwner):
		return
	
	var mousepos: Vector2 = get_global_mouse_position()
	var pos: Vector2 = weaponOwner.get_ref().get_position()
	
	var delta_x = mousepos.x - pos.x
	var delta_y = pos.y - mousepos.y
	
	point_weapon_by_angle(atan2(delta_y, delta_x) * -1)
