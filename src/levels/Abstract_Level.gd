extends TileMap


signal shift_toggle

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func do_shift():
	emit_signal("shift_toggle")
	if is_instance_valid($'Realm_Filter'):
		$'Realm_Filter'.visible = !$'Realm_Filter'.visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
