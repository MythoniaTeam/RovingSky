extends CharacterBody2D

var Di:Vector2
var spd = 400
var polygon = []
var mode = 0
var sail_v:Vector2

func _ready():
	scale = Vector2(5,5)
	pass

func _physics_process(delta):
	if mode <= 0:
		form_polygons()
		mode += 1
	#move(delta)
	sail_v = sail_v * 0.5
	position += sail_v
	print(sail_v)
	
func move(delta):
	Di.x = Input.get_axis("ui_left","ui_right")
	Di.y = Input.get_axis("ui_up","ui_down")
	Di = Di.normalized()
	set_velocity(Di*spd)
	#move_and_collide(Di*spd*delta)
	move_and_slide()
	get_parent().v = get_last_motion()
	

func form_polygons():
	var a = $Blocks.get_used_cells(0)
	var ps = global_position 
	print(a)
	var base:PackedScene = load("res://collision.tscn")
	for i in range(0,len(a)):
		var tile_data:TileData = $Blocks.get_cell_tile_data(0,a[i])
		var Collision_type = tile_data.get_custom_data("Collision_type")
		var new_base = base.instantiate()
		var final_ps = (to_local(ps)) + $Blocks.map_to_local(a[i]) - Vector2(1,0)
		new_base.type = "boat" + str(Collision_type)
		new_base.position = final_ps
		new_base.scale = scale/5
		add_child(new_base)
	
