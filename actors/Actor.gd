extends KinematicBody2D

class_name Actor

export var speed := Vector2(3000.0, 3000.0)
export var friction := 800

var _velocity := Vector2.ZERO
var _direction := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
