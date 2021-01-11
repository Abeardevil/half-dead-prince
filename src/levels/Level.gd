extends Node

var game_scene : PackedScene = load("res://src/levels/Nav.tscn")
var game_instance = null

func _ready():
	$Button.connect("button_up", $".", "start_game")
	pass

func start_game():
	Globals.game_running = true
	Globals.living_realm_shown = true
	Globals.player_score = 0
	game_instance = game_scene.instance()
	add_child(game_instance)

func _process(delta):
	if Globals.game_running && $Button.visible:
		$Button.visible = false
		$ScoreDisplay.visible = false
	elif !Globals.game_running && !$Button.visible:
		$Button.visible = true
		$ScoreDisplay.visible = true
		
		game_instance.queue_free()
	pass
