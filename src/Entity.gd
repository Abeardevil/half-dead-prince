extends Node

class_name Entity

export var in_living_realm = true

var realm_indicator
var realm_indicator_scene : PackedScene = load('res://src/lights/Realm_Indicator.tscn')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func add_indicator():
	realm_indicator = realm_indicator_scene.instance()
	add_child(realm_indicator)
	
	if !in_living_realm:
		realm_indicator.set_spirit_glow_vis(true)
		
	if is_instance_valid(get_parent()):
		get_parent().connect('shift_toggle', $'.', _toggle_indicator())
	

func _toggle_indicator():
	if in_living_realm:
		realm_indicator.toggleLivingGlow()
	else:
		realm_indicator.toggleSpiritGlow()
