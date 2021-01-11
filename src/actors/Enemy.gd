extends Actor

class_name Enemy

var player: Player
var nav : Navigation2D = null setget set_nav
var path = []
var goal = Vector2()
var minPlayerDistance = 35.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_nodes_in_group("player").size() > 0:
		player = get_tree().get_nodes_in_group("player")[0]
		set_nav(get_parent())
		speed = 200.0

func _physics_process(delta):
	if is_instance_valid(player) && player.global_position != goal:
		goal = player.global_position
		update_path()
	move_along_path()

func move_along_path():
	if path.size():
		if global_position.distance_to(path[0]) < minPlayerDistance:
			if path.size() > 1:
				path.remove(0)
				move_along_path()
			else:
				return
		else:
			var d := global_position.distance_to(path[0])
			var delta_vect : Vector2 = path[0] - position
			face_angle = atan2(path[0].y - position.y, path[0].x - position.x)
			move_and_slide(delta_vect.normalized() * speed)

func update_path():
	path = nav.get_simple_path(global_position, goal, true)
	
func set_nav(new_nav: Navigation2D):
	nav = new_nav
