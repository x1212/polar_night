
extends Sprite3D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	set_process(true)
	pass

var pos = Vector3(0,0,0)
func _process(delta):
	var new_pos = get_parent().get_translation()
	if (new_pos.x > pos.x):
		get_parent().set_scale(Vector3(-1,1,1))
	elif (new_pos.x < pos.x):
		get_parent().set_scale(Vector3(1,1,1))
	pos = new_pos
	
	pass

