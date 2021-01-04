extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponType = weaponTypes.SWORD


func _on_Sword_body_entered(body):
	print("Body entered: " + body)
	if owner == null:
		owner == body
		print("Now owned by " + owner.name)
