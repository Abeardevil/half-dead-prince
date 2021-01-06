extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name Realm_Indicator

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_spirit_glow_vis(value : bool):
	$Spirit_Realm_Glow.visible = value
	
func set_living_glow_vis(value : bool):
	$Living_Realm_Glow.visible = value

func toggle_spirit_glow() -> bool:
	$Spirit_Realm_Glow.visible = !$Spirit_Realm_Glow.visible
	return $Spirit_Realm_Glow.visible
	
func toggle_living_glow() -> bool:
	$Living_Realm_Glow.visible = !$Living_Realm_Glow.visible	
	return $Living_Realm_Glow.visible
