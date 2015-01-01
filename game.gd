
extends Spatial

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	pass

var time = 0.0
var gameover = false
func _process(delta):
	time += delta
	
	if (gameover):
		return
	
	if (get_node("human_spawns").get_child_count() <= 0):
		gameover = true
	if (get_node("snowman_spawns").get_child_count() <= 0):
		gameover = true
	
	if (gameover):
		var label = load("res://game_over.scn").instance()
		var hours = int(time / 3600)
		var minutes = int(  (time - hours * 3600) / 60  )
		var seconds = int(  (time - hours * 3600 - minutes * 60)  )
		label.set_text(str(label.get_text(),"\nTime survived: ", hours, "h ", minutes, "m ", seconds, "s"))
		queue_free()
		get_tree().get_root().add_child(label)
