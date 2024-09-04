class_name Player
extends CharacterBody2D

var master:int
var Di:Vector2
var spd = 100
var joy = false
var inter:interactable


func _physics_process(delta):
	move(delta)
	$inter.visible = (inter != null)
	#print(master)
	
func move(delta):
	if joy:
		Di.x = Input.get_joy_axis(master,0)
		Di.y = Input.get_joy_axis(master,1)
		Di = Di.normalized()
		set_velocity(Di*spd)
		move_and_slide()
		if abs(Di.x) > 0 or abs(Di.y) > 0:
			$AnimatedSprite2D.play("Walk")
			$AnimatedSprite2D.flip_h = Di.x<0
		else:
			$AnimatedSprite2D.play("Stand")
	else:
		Di.x = Input.get_axis("a","d")
		Di.y = Input.get_axis("w","s")
		Di = Di.normalized()
		set_velocity(Di*spd)
		move_and_slide()
		if Input.is_action_pressed("a") or Input.is_action_pressed("d") or Input.is_action_pressed("w") or Input.is_action_pressed("s"):
			$AnimatedSprite2D.play("Walk")
			$AnimatedSprite2D.flip_h = Di.x<0
		else:
			$AnimatedSprite2D.play("Stand")
		if Input.is_action_just_pressed("e"):
			inter.interact()
		
	position +=  get_parent().v
	
	
	
	

