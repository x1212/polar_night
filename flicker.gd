
extends AnimationPlayer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	randomize()
	play("flicker")
	set_speed(   1.0  +  (randf() - 0.5) * 0.4   )
	# Initalization here
	pass


