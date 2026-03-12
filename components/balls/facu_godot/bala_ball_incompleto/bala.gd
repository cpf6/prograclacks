extends Area2D

var original
@onready var direccion = randf_range(0,6.28)

func _physics_process(delta):
	position += Vector2(1,0).rotated(direccion)
	for carlos in get_overlapping_bodies():
		if carlos is Ball:
			carlos.attack(carlos,8)
