extends Ability

var throwing_axe: Resource = preload("res://Scenes/Abilities/ThrowingAxe/ThrowingAxe.tscn")
var spinner_axe: Resource = preload("res://Scenes/Abilities/ThrowingAxe/SpinnerAxe.tscn")

var upgraded_spinner_level = 0
var axe_count: int = 0
var spinner_cost: int = 5

func _ready() -> void:
	_activate()

func _activate(spawn: Transform2D = Transform2D()) -> void:
	var targets  = G.get_closest_enemies(owner.global_position)

	for i in range(_get_num_of_projectiles()):
		var target: Vector2
		if targets and G.index_exists(targets, i):
			if is_instance_valid(targets[i]):
				target = targets[i].global_position
		else:
			target = G.get_snapped_angle(i, _get_num_of_projectiles(), owner.global_position, 32)
		Create.projectile(throwing_axe, owner.transform.looking_at(target), base)
		if upgraded_spinner_level > 0:
			axe_count += 1
		if base_delay > 0:
			await get_tree().create_timer(base_delay).timeout
		
	if axe_count - spinner_cost >= 0:
		Create.projectile(spinner_axe, spawn)
		axe_count = max(axe_count - spinner_cost, 0)

func _on_timer_timeout() -> void:
	_activate()
