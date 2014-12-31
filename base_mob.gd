
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
	randomize()
	pass




var mob_class = "void"  # class refers to whether the mob tries to build a new spawn or to fight enemies or destroy their spawns
var mob_type = "void"   # type refers to whether the mob is a human or snowman
var active = false
var health = BASE_HEALTH
var max_health = BASE_HEALTH
var ep = 0
var support_val = 0     # how much this unit is supported/unsupported by allied/enemy camps

var enemy_spawn_root_node
var enemy_unit_root_node

var attack_range = []

var dir = Vector3(1,0,0)
var old_pos = Vector3(0,0,0)

var tick = 1.0
var tick_timer = tick
var health_tick = 2
func _fixed_process(delta):
	tick_timer -= delta
	
	if (health < 0):
		queue_free()
	
	if ( mob_type == SNOWMAN ):
		enemy_spawn_root_node = get_parent().get_parent().get_node("human_spawns")
		enemy_unit_root_node  = get_parent().get_parent().get_node("human_units")
	elif ( mob_type == HUMAN ):
		enemy_spawn_root_node = get_parent().get_parent().get_node("snowman_spawns")
		enemy_unit_root_node  = get_parent().get_parent().get_node("snowman_units")
	
	
	if ( active and mob_type != "void" ):
		show()
		ai()
		var rand_factor = abs(  (get_translation()-old_pos).length() - dir.length()*delta  )*50
		#print(rand_factor)
		old_pos = get_translation()
		var randir = (dir*(1.0-rand_factor) + rand_factor*Vector3(rand_range(-1.0,1.0),0.0,rand_range(-1.0,1.0)).normalized())/2
		randir = randir.normalized()
		randir.y = 0.0
		move(randir.normalized() * delta)
	else:
		#hide()
		if (active):
			print("warning, voidtype mob")
		elif ( mob_type != "void" ):
			print("warning, inactive mob")
		else:
			print("warning, inactive voidtype mob")
		pass
	
	
	
	
	if (tick_timer < 0.0):
		tick_timer = tick
		health_tick -= 1
		if (health_tick < 0):
			health += 1 + support_val
			health_tick = 2
	
	pass


func ai():
	if (mob_type == SNOWMAN ):
		dir = Vector3(1,0,0)
	else:
		dir = Vector3(-1,0,0)
	
	if (attack_range.size()>0 and tick_timer < 0.0):
		randomize()
		var victim = randi()%attack_range.size()
		ep += attack_range[victim].damage(sqrt(ep/10)+1)
	
	max_health = BASE_HEALTH*(sqrt(ep/10)+1)
	if (get_child_count() - 2 < sqrt(ep/10)+1 ):
		var new_healthbar = get_node("healthbar").duplicate()
		add_child(new_healthbar)
		var pos = new_healthbar.get_translation()
		pos.y = pos.y + (sqrt(ep/10))*0.2
		new_healthbar.set_translation(pos)
	
	pass


func support():
	support_val += 1
	pass

func unsupport():
	support_val -= 1
	pass




func damage(level):
	health -= level
	if ( health < 0 ):
		return 20
	else:
		return 1



func _on_Area_body_enter( body ):
	if (body.mob_type != mob_type):
		attack_range.append(body)
	pass # replace with function body




func _on_Area_body_exit( body ):
	if (body.mob_type != mob_type):
		attack_range.erase(body)
	pass # replace with function body
