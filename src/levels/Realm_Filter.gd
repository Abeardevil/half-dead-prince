extends CanvasModulate

func _process(delta):
	if visible == Globals.living_realm_shown:
		visible = !Globals.living_realm_shown
		pass
