class_name interactable
extends Area2D

signal interacted

func _init():
	#collision_layer = 0
	#collision_mask = 0
	#set_collision_mask_value(1,true)
	pass
	
func interact():
	print("sail")
	rotation += PI/4
	interacted.emit()



func _on_body_entered(player:Player):
	player.inter = self

func _on_body_exited(player:Player):
	player.inter = null
	
func _process(delta):
	get_parent().get_parent().sail_v.x += sin(rotation+PI)
	get_parent().get_parent().sail_v.y += cos(rotation+PI)
