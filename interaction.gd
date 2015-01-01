
extends Area

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	pass




func _on_Area_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if (event.is_action("LMB") and event.is_pressed()):
		var new_clouds = load("res://support_area.scn").instance()
		new_clouds.set_translation(click_pos+Vector3(0.0,0.25,0.0))
		get_parent().add_child(new_clouds)
		new_clouds.mob_type = "human"
		print("cloudy")
		print(click_pos)
	if (event.is_action("RMB") and event.is_pressed()):
		var new_camp = load("res://support_area.scn").instance()
		new_camp.set_translation(click_pos+Vector3(0.0,1.0,0.0))
		get_parent().add_child(new_camp)
		new_camp.mob_type = "snowman"
		print("burning")
		print(click_pos)
	
	pass # replace with function body
