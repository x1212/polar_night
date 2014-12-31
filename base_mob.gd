
extends KinematicBody

# member variables here, example:
# var a=2
# var b="textvar"

var FIGHTER = "fighter"
var DESTROYER = "destroyer"
var VILLAGER = "villager"

var SNOWMAN = "snowman"
var HUMAN = "human"

var BASE_HEALTH = 10


func _ready():
	set_fixed_process(true)
	pass




var mob_class = "void"  # class refers to whether the mob tries to build a new spawn or to fight enemies or destroy their spawns
var mob_type = "void"   # type refers to whether the mob is a human or snowman
var active = false
var health = BASE_HEALTH
var max_health = BASE_HEALTH

var enemy_spawn_root_node
var enemy_unit_root_node

var dir = Vector3(1,0,0)

func _fixed_process(delta):
	
	if ( mob_type == SNOWMAN ):
		enemy_spawn_root_node = get_parent().get_parent().get_node("human_spawns")
		enemy_unit_root_node  = get_parent().get_parent().get_node("human_units")
	elif ( mob_type == HUMAN ):
		enemy_spawn_root_node = get_parent().get_parent().get_node("snowman_spawns")
		enemy_unit_root_node  = get_parent().get_parent().get_node("snowman_units")
	
	
	if ( active and mob_type != "void" ):
		show()
		ai()
		move(dir.normalized() * delta)
	else:
		#hide()
		if (active):
			print("warning, voidtype mob")
		elif ( mob_type != "void" ):
			print("warning, inactive mob")
		else:
			print("warning, inactive voidtype mob")
		pass
	pass


func ai():
	if (mob_type == SNOWMAN ):
		dir = Vector3(1,0,0)
	else:
		dir = Vector3(-1,0,0)
	pass


func support():
	
	pass

func unsupport():
	
	pass




func _on_Area_body_enter( body ):
	pass # replace with function body
