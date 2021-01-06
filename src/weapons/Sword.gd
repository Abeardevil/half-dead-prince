extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponType = weaponTypes.SWORD
	$".".connect("body_entered", $".", "_on_Weapon_body_entered")
	$".".connect("body_exited", $".", "_on_Weapon_body_exited")
	

#func _process(delta):
#	calculate_weapon_position()


#func _on_Sword_body_entered(body):
#	_on_Weapon_body_entered()
#	print("Body entered: " + body.name)
#	if !is_instance_valid(weaponOwner):
#		weaponOwner = weakref(body)
#		print("Now owned by " + weaponOwner.get_ref().name)
