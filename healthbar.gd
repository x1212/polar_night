
extends Quad

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	hide()
	pass


func _process(delta):
	var parent = get_parent()
	if (parent.health < parent.max_health):
		show()
		var scale = Vector3(parent.health*1.0/parent.max_health,1,1)
		set_scale(scale)
	else:
		#hide()
		show()
