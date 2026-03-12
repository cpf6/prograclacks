extends Ball

@export var espada : Node2D
@export var area_espada : Area2D
@export var bala_escena : PackedScene

func ball_physics_process(delta : float):
	pass


func dash():
	apply_central_impulse(Vector2(1,0).rotated(randf_range(0,6.28)) * 200)


func disparar():
	var bala = bala_escena.instantiate()
	get_parent().add_child(bala)
	bala.global_position = global_position
