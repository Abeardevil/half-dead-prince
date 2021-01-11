extends Node

var living_realm_shown = true
var player_health = 3
var player_score : int = 0
var spawn_point : Position2D = null
var wisp_scene : PackedScene = load("res://src/actors/Wisp.tscn")
var sword_scene : PackedScene = load("res://src/weapons/Sword.tscn")
var game_running : bool = false

enum layer_enums {living_realm = 5, spirit_realm = 6,}

func entity_display(entity_instance, has_hit_box = true):
	if entity_instance.in_living_realm:
		if is_instance_valid(entity_instance.realm_indicator):
			entity_instance.realm_indicator.set_living_glow_vis(!living_realm_shown)
		if has_hit_box && entity_instance.get_collision_layer_bit(layer_enums.living_realm) != true:
			entity_instance.set_collision_layer_bit(layer_enums.living_realm, true)
			entity_instance.set_collision_layer_bit(layer_enums.spirit_realm, false)
			entity_instance.set_collision_mask_bit(layer_enums.living_realm, true)
			entity_instance.set_collision_mask_bit(layer_enums.spirit_realm, false)
	else:
		if is_instance_valid(entity_instance.realm_indicator):
			entity_instance.realm_indicator.set_spirit_glow_vis(living_realm_shown)
		if has_hit_box && entity_instance.get_collision_layer_bit(layer_enums.spirit_realm) != true:
			entity_instance.set_collision_layer_bit(layer_enums.spirit_realm, true)
			entity_instance.set_collision_layer_bit(layer_enums.living_realm, false)
			entity_instance.set_collision_mask_bit(layer_enums.spirit_realm, true)
			entity_instance.set_collision_mask_bit(layer_enums.living_realm, false)

func spawn_new_wisp():
	if is_instance_valid(spawn_point):
		var spawns_in_living_realm = round(rand_range(0, 1))
		var new_wisp = wisp_scene.instance()
		spawn_point.get_parent().add_child(new_wisp)
		new_wisp.position = spawn_point.position
		new_wisp.in_living_realm = true if spawns_in_living_realm == 1 else false
		new_wisp.pick_up_weapon(sword_scene.instance())
		pass
	pass
