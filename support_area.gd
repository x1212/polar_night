
extends Area

# member variables here, example:
# var a=2
# var b="textvar"

var mob_type = "void"

func _ready():
	set_process(true)
	pass


var time_left = 5.0
func _process(delta):
	if (get_child_count() == 0 and time_left > 0.0):
		if (mob_type == "snowman"):
			var camp = load("snow.scn").instance()
			camp.set_translation(Vector3(0.0,0.0,0.0))
			add_child(camp)
		elif (mob_type == "human"):
			var camp = load("fireplace.scn").instance()
			camp.set_translation(Vector3(0.0,0.2,0.0))
			add_child(camp)
	elif (get_child_count() == 0 and time_left < 0.0):
		queue_free()
	if (time_left < 0.0 and get_child_count() > 0):
		get_child(0).queue_free()
	time_left -= delta


#func _on_Area_body_enter( body ):
#	
#	pass # replace with function body


#func _on_Area_body_exit( body ):
#	
#	pass # replace with function body

func _on_Area_body_enter( body ):
	if (  body.mob_type == mob_type  ):
		body.support()
	else:
		body.unsupport()



func _on_Area_body_exit( body ):
	if (  body.mob_type == mob_type  ):
		body.unsupport()
	else:
		body.support()