extends Resource
class_name EntityProperties

@export var mob_name: String = "Unnamed"
@export var mob_sprite: Texture
@export_group("Visual")
@export var color: Color = Color.WHITE
@export var animation: String = "RESET"

@export_group("Offensive")
@export var damage: int = 10:
	get:
		return damage

@export var firerate: float = 1.0:
	get:
		return firerate

@export_group("Defensive")
@export var health: int = 10:
	get:
		return health
@export var randomize_health: float = 1.2

@export var knockback_resistance: float = 1.0:
	get:
		return knockback_resistance

@export_group("Movement")
@export var speed: int = 1600:
	get:
		return speed

@export var use_soft_collision: bool = true
@export var soft_collision_force: float = 400
@export_flags_2d_physics var layers_2d_physics: int = 4

func _ready():
	randomize()
	health = randi_range(health, ceil(health * randomize_health))
