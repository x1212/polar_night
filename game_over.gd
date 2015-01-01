
extends Label

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	set_process(true)
	
	pass



func _process(delta):
	if (Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("ui_accept")):
		get_tree().quit()

