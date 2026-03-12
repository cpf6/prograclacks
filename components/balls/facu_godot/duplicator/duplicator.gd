extends Ball

var original : Node = self
var balls : int = 1

func ball_physics_process(delta : float):
	if position.x < 0:
		constant_force = Vector2(1,0) * 200 
	else:
		constant_force = Vector2(-1,0) * 200
	
	if original == null:
		queue_free()
	
	if original == self and balls > 1:
		$StarLabel.visible = true
	else:
		$StarLabel.visible = false
	
	for i in get_colliding_bodies():
		if i is Ball and attack_timer.is_stopped():
			if i.ball_name == "Duplicator":
				if i.original != original:
					attack(i,1)
					attack_timer.start()
			else:
				attack(i,1)
				attack_timer.start()
	
	balls = 0
	for i in get_parent().get_children():
		if i is Ball:
			if i.ball_name == "Duplicator":
				balls += 1
	string = "Balls: " + str(balls)


func _on_duplicate_timer_timeout() -> void:
	var clone = preload("uid://dytov7af8x4bn").instantiate()
	get_parent().add_child(clone)
	clone.color = original.color
	clone.original = original
	clone.global_position = global_position
	clone.linear_velocity = linear_velocity
