extends Actor

class_name Enemy

var player: Player
var nav : Navigation2D = null setget set_nav
var path = []
var goal = Vector2()
var pathLine: Line2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	set_nav(get_parent().get_parent())
	pathLine = get_parent().get_parent().get_parent().get_node("Line2D")
	speed = 200.0

func _physics_process(delta):
	if player.global_position != goal:
		goal = player.global_position
		update_path() 
		pathLine.clear_points()
		for i in path:
			pathLine.add_point(i)
		
	move_along_path()

func move_along_path():
	if path.size():
		if global_position.distance_to(path[0]) < 2:
			path.remove(0)
			move_along_path()
		else:
			var d := global_position.distance_to(path[0])
			position = global_position.linear_interpolate(path[0], (speed * get_physics_process_delta_time()) / d)
	
	
func update_path():
	path = nav.get_simple_path(global_position, goal, true)
	
func set_nav(new_nav: Navigation2D):
	nav = new_nav
