extends TileMap

class_name Abstract_Level

export var living_realm_shown = true

signal shift_toggle

func _ready():
   pass # Replace with function body.
   
func _process(delta):
	if is_instance_valid($'Realm_Filter') && living_realm_shown == $'Realm_Filter'.visible:
		$'Realm_Filter'.visible = !living_realm_shown

func do_shift():
	emit_signal("shift_toggle")
	living_realm_shown = !living_realm_shown
