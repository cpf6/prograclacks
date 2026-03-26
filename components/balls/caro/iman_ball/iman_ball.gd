extends Ball

@export_range(50, 500) var magnet_radius : float = 220.0
@export_range(50, 500) var magnet_force  : float = 800.0
@export_range(50, 600) var dash_force    : float = 250.0

var _attract    : bool = true  # true = atrae, false = repele
var _bonus_dmg  : int  = 0     # daño extra acumulado por choques
var dano_total  : int  = 0

#func _ready() -> void:
	#await get_tree().physics_frame
	#var dir = Vector2(1, 0).rotated(randf_range(0.0, TAU))
	#apply_central_impulse(dir * dash_force)

#func _draw() -> void:
	#draw_circle(Vector2.ZERO, magnet_radius * size, Color(0, 0.5, 1, 0.15))
	#draw_arc(Vector2.ZERO, magnet_radius * size, 0, TAU, 64, Color(0, 0.5, 1, 0.6), 2.0)

func ball_physics_process(_delta: float) -> void:
	string = "Damage: " + str(dano_total)
	_aplicar_fuerza_iman()
	queue_redraw()

func _aplicar_fuerza_iman() -> void:
	for node in get_parent().get_children():
		if node == self or not node is Ball:
			continue
		var diff = node.global_position - global_position
		var dist = diff.length()
		if dist <= 0.01 or dist > magnet_radius * size:
			continue
		# Fuerza más fuerte cuanto más cerca esté
		var fuerza = magnet_force * (1.0 - dist / (magnet_radius * size))
		var dir = diff.normalized()
		if _attract:
			node.apply_central_force(-dir * fuerza)  # atrae hacia nosotros
		else:
			node.apply_central_force(dir * fuerza)   # repele lejos

func toggle_mode() -> void:
	_attract = not _attract
	if _attract:
		$AnimationPlayer.play("atraer")
	else:
		$AnimationPlayer.play("repeler")

func _on_body_entered(body: Node) -> void:
	if not body is Ball or body == self:
		return
	_bonus_dmg += 5
	var dmg = 10 + _bonus_dmg
	body.life -= dmg
	dano_total += dmg
	# Resetear bonus si se vuelve muy alto
	if _bonus_dmg >= 50:
		_bonus_dmg = 0
