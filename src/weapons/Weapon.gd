extends Area2D

class_name Weapon

enum weaponTypes {SWORD, RANGED}
enum weaponStates {IDLE, ATTACK}

var weaponOwner: WeakRef
var weaponType: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
