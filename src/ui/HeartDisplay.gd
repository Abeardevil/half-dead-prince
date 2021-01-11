extends Node2D

var heart_scene = load("res://src/ui/Heart.tscn")
var heart_instances = []
var temp_heart_cnt

func _ready():
	for i in range(3):
		heart_instances.append(heart_scene.instance())
		heart_instances[i].position = Vector2(i * 64, 0)
		add_child(heart_instances[i])
		pass

func _process(delta):
	if temp_heart_cnt != Globals.player_health:
		for i in range(3):
			if Globals.player_health > i:
				heart_instances[i].is_filled = true
			else:
				heart_instances[i].is_filled = false
	temp_heart_cnt = Globals.player_health
	pass
