extends Ball

@export_range(50, 400) var explosion_radius : float = 180.0
@export_range(10, 100) var explosion_damage : int   = 40
@export_range(100, 600) var dash_force      : float = 300.0

var _exploding : bool = false
var dano_total : int = 0

func ball_physics_process(_delta: float) -> void:
	string = "Damage: " + str(dano_total)

func dash() -> void:
	var dir = Vector2(1, 0).rotated(randf_range(0.0, TAU))
	apply_central_impulse(dir * dash_force)

func explode() -> void:
	if _exploding:
		return
	_exploding = true

	for node in get_parent().get_children():
		if node == self or not node is Ball:
			continue
		var dist = global_position.distance_to(node.global_position)
		if dist <= explosion_radius * size:
			node.life -= explosion_damage
			dano_total += explosion_damage

	$AnimationPlayer.play("explosion_flash")

	_exploding = false
