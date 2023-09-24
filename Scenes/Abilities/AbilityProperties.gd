extends Resource
class_name AbilityProperties

# Manager Stats
@export var damage: int = 10
@export var damage_mod: float = 1.0
@export var damage_range: float = 0.2
@export var critical_chance: float = 5.0
@export var critical_amplifier: float = 2.0
@export var projectiles: int = 1
@export var cooldown: float = 2.5
@export var delay: float = 0.1
@export var velocity: float = 10.0
@export var size : float = 1.0
@export var bounces: int = 0
@export var penetration: int = 0
@export var knockback: float = 1.0
@export var duration: float = -1.0

func roll_damage() -> Array:
	randomize()
	var dmg = damage * damage_mod
	var crit: bool = randf_range(0.0, 100.0) <= critical_chance
	if crit:
		dmg *= critical_amplifier
	return [round(randf_range(dmg * (1 - damage_range), dmg * (1 + damage_range))), crit]
