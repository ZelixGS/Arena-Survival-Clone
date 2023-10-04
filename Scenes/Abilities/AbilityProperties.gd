class_name AbilityProperties extends Resource

# Manager Stats
@export var ability_name: String = ""
@export var activation: G.Activation = G.Activation.TIMER

@export_group("Damage")
@export var amount: int = 10
@export var modifier: float = 1.0
@export var variance: float = 0.2
@export var critical_chance: float = 5.0
@export var critical_amplifier: float = 2.0
@export var type: G.Damage = G.Damage.PHYSICAL

@export_group("Projectile")
@export var velocity: float = 10.0
@export var cooldown: float = 2.5
@export var size : float = 1.0
@export var projectiles: int = 1
@export var delay: float = 0.1
@export var bounces: int = 0
@export var penetration: int = 0
@export var knockback: float = 1.0
@export var duration: float = -1.0

@export_group("Proc")
@export var proc_chance: float = 0.0

func roll_damage():
	return randf_range(amount * (1 - variance), amount * (1 + variance)) * modifier

func is_critical() -> bool:
	randomize()
	return randf_range(0.0, 100.0) <= critical_chance

func is_proc() -> bool:
	randomize()
	return randf_range(0.0, 100.0) <= proc_chance
