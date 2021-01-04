extends Weapon

var draw_radius := 20

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponType = weaponTypes.SWORD

func _process(delta):
	if is_instance_valid(weaponOwner):
		var mousepos: Vector2 = get_global_mouse_position()
		var pos: Vector2 = weaponOwner.get_ref().get_position()
		
		var delta_x = mousepos.x - pos.x
		var delta_y = pos.y - mousepos.y
		
		rotation = atan2(delta_y, delta_x) * -1
		
		var finalPos := Vector2.ZERO
		
		finalPos.x = pos.x + cos(rotation)*draw_radius
		finalPos.y = pos.y + sin(rotation)*draw_radius
		
		set_position(finalPos)

func _on_Sword_body_entered(body):
	print("Body entered: " + body.name)
	if !is_instance_valid(weaponOwner):
		weaponOwner = weakref(body)
		print("Now owned by " + weaponOwner.get_ref().name)
