
extends Area

# member variables here, example:
# var a=2
# var b="textvar"

var SNOWMAN = "snowman"
var HUMAN = "human"

func _ready():
	set_fixed_process(true)
	pass



var spawn_step = 2.0
var spawn_timer = spawn_step

func _fixed_process( delta ):
	if (spawn_timer < 0.0):
		spawn_mob()
		spawn_timer = spawn_step
	spawn_timer -= delta
	


export(String, "snowman", "human") var mob_type

func spawn_mob():
	# todo duplicate mob and activate it
	
	var base_mob = load("res://base_mob.scn").instance()
	var mob_sprite = load("res://mob_sprite.scn").instance()
	base_mob.mob_type = mob_type
	base_mob.add_child(mob_sprite)
	var pos = get_translation()
	pos.y = 1
	base_mob.set_translation(pos)
	
	if ( mob_type == SNOWMAN ):
		mob_sprite.set_texture(load("res://gfx/snowman.png"))
		get_parent().get_parent().get_node("snowman_units").add_child(base_mob)
		base_mob.active = true
	elif ( mob_type == HUMAN ):
		mob_sprite.set_texture(load("res://gfx/human.png"))
		get_parent().get_parent().get_node("human_units").add_child(base_mob)
		var fire = load("res://fire.scn").instance()
		mob_sprite.add_child(fire)
		fire.set_translation(Vector3(-0.35,0.27,0.1))
		base_mob.active = true
	else:
		print("warning: unknown spawner type")
	
	
	
	pass


func set_mob_type( type ):
	# todo test for it extending basemob or something
	mob_type = type




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

