extends Weapon

var anim_value

# Called when the node enters the scene tree for the first time.
func _ready():
	weaponType = weaponTypes.SWORD
	$".".connect("body_entered", $".", "_on_Weapon_body_entered")
	$".".connect("body_exited", $".", "_on_Weapon_body_exited")

func start_anim():
	if is_instance_valid($"AnimationPlayer"):
		var anim_player : AnimationPlayer = $"AnimationPlayer"
		anim_player.play("Swing")
		yield(anim_player, "animation_finished")
		anim_cleanup()
	pass

func anim_cleanup():
	weapon_angle = angle_to_side
	pass
