extends Ball

@export var sword_node : Node2D
@export var sword : Area2D
@export var dash_sound : AudioStreamPlayer2D

var damage : float = 1
var dashing : bool = false

func ball_physics_process(delta : float):
	string = "Damage: " + String.num(damage,2)
	if not dashing:
		sword_node.rotation += 10 * delta
	
	for body in sword.get_overlapping_bodies():
		if body is Ball and body != self:
			attack(body,floor(damage))
			damage *= 1.25


func _on_dash_timer_timeout() -> void:
	dashing = true
	await get_tree().create_timer(0.1).timeout
	dash_sound.play()
	apply_central_impulse(global_position.direction_to(sword.global_position) * 2000)
	await get_tree().create_timer(0.1).timeout
	dashing = false
