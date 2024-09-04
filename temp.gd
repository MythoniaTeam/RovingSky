extends CollisionPolygon2D
var type:String = "boat3"

func load_file(name):
	var file = FileAccess.open("res://Collisions/" + name + ".data",FileAccess.READ)
	polygon = file.get_var()
	file.close()
	
func _ready():
	load_file(type)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
