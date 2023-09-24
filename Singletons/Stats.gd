extends Node

var base: Dictionary = {
	"damage": 1.0,
	"projectiles": 0,
	"size": 1.0,
	"velocity": 1.0,
	"duration": 1.0,
	"cooldown": 1.0,
	"penetration": 0,
	"knockback": 1.0,
	"armor": 1.0,
	"health": 1.0,
	"regeneration": 0.0,
	"shield": 0,
	"invulnarbility_time": 0.0,
	"speed": 1.0,
	"magnet": 1.0,
	"experience_rate": 1.0,
	"gold_find": 1.0,
	"magic_find": 1.0,
	"spawn_rate": 1.0,
	"spawn_limit": 300,
	"god": 0,
}

func _ready() -> void:
	Events.connect("change_stat", modify_stat)

func get_damage() -> float:
	return base["damage"]
	
func get_projectiles() -> int:
	return base["projectiles"]
	
func get_size() -> float:
	return base["size"]
	
func get_velocity() -> float:
	return base["velocity"]

func get_duration() -> float:
	return base["duration"]

func get_cooldown() -> float:
	return base["cooldown"]

func get_penetration() -> int:
	return base["penetration"]

func get_knockback() -> float:
	return base["knockback"]

func get_spawn_rate() -> float:
	return base["spawn_rate"]

func get_experience_rate() -> float:
	return base["experience_rate"]

func get_spawn_limit() -> int:
	return base["spawn_limit"]

func modify_stat(stat: String, value: float) -> void:
	print("Changing %s by %d" % [stat, value])
	if base.has(stat):
		base[stat] = value
