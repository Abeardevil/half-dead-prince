 extends KinematicBody2D

class_name Actor

export var speed := 3000.0
export var friction := 800
export var equipped_weapon : PackedScene
export var arm_length := 0

var _velocity := Vector2.ZERO
var _direction := Vector2.ZERO
var face_angle : float = 0
var current_weapon : Weapon
var reachable_weapon : Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	if equipped_weapon != null && equipped_weapon.can_instance():
		pick_up_weapon(equipped_weapon.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_weapon_position()
	pass
	
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
		
		
