extends Node
@onready var object = get_parent()
@onready var count = 0
func save(name):
	var file = FileAccess.open("res://Collisions/" + name + ".data",FileAccess.WRITE)
	file.store_var(object.polygon)
	file.close()
	
func load_file(name):
	var file = FileAccess.open("res://Collisions/" + name + ".data",FileAccess.READ)
	object.polygon = file.get_var()
	file.close()

func init():
	var file = FileAccess.open("res://Collisions/count.data",FileAccess.READ)
	count = file.get_var()
	count += 1
	file.close()
	file = FileAccess.open("res://Collisions/count.data",FileAccess.WRITE)
	file.store_var(count)
	file.close()
	print(count)

	
func _ready():
	#init()
	#save("Boat"+str(count))
	pass
	

