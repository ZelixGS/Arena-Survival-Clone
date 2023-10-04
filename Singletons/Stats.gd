extends Node

var _base: Dictionary = {
	"damage": 1.0,
	"velocity": 1.0,
	"cooldown": 1.0,
	"duration": 1.0,
	"size": 1.0,
	"knockback": 1.0,
	"critical_chance": 0.05,
	"critical_amp": 2.0,
	"projctiles": 0,
	"chain": 0,
	"penetration": 0,
	"health": 1.0,
	"armor": 0,
	"shield": 1.0,
	"regeneration": 1.0,
	"speed": 1.0,
	"magnet": 1.0,
	"experience": 1.0,
	"avarice": 1.0,
	"serendipity": 1.0,
	"spawn_base": 1,
	"spawn_rate": 1.0,
	"spawn_limit": 300,
}

var _clean: Dictionary = {
	"damage": 1.0,
	"velocity": 1.0,
	"cooldown": 1.0,
	"duration": 1.0,
	"size": 1.0,
	"knockback": 1.0,
	"critical_chance": 0.0,
	"critical_amp": 1.0,
	"projctiles": 0,
	"chain": 0,
	"penetration": 0,
	"health": 1.0,
	"armor": 0,
	"shield": 1.0,
	"regeneration": 1.0,
	"speed": 1.0,
	"magnet": 1.0,
	"experience": 1.0,
	"avarice": 1.0,
	"serendipity": 1.0,
	"spawn_base": 0,
	"spawn_rate": 1.0,
	"spawn_limit": 0,
}

var _stat: Dictionary = {
	"damage": 1.0,
	"velocity": 1.0,
	"cooldown": 1.0,
	"duration": 1.0,
	"size": 1.0,
	"knockback": 1.0,
	"critical_chance": 0.0,
	"critical_amp": 1.0,
	"projctiles": 0,
	"chain": 0,
	"penetration": 0,
	"health": 1.0,
	"armor": 0,
	"shield": 1.0,
	"regeneration": 1.0,
	"speed": 1.0,
	"magnet": 1.0,
	"experience": 1.0,
	"avarice": 1.0,
	"serendipity": 1.0,
	"spawn_base": 0,
	"spawn_rate": 1.0,
	"spawn_limit": 0,
}

var upgrades: Array[Upgrade] = []

func calculate_stats() -> void:
	_stat = _clean.duplicate()
	for upgrade in upgrades:
		if not _stat.has(upgrade.stat):
			continue
		if upgrade.calculation == upgrade.Calculation.ADDITIVE:
			_stat[upgrade.stat] += upgrade.amount
		else:
			print("%s | %s" % [_stat[upgrade.stat], _stat[upgrade.stat] * upgrade.amount])
			_stat[upgrade.stat] *= upgrade.amount


func _ready() -> void:
	Events.connect("ui_selected_upgrade", manage_upgrades)

func manage_upgrades(upgrade: Upgrade) -> void:
	upgrades.append(upgrade)
	print("Added [%s]" % upgrade.name)
	calculate_stats()

# 
# Offensive Stats
# 
func get_damage() -> float:
	return _base["damage"] * _stat["damage"]
	
func get_velocity() -> float:
	return _base["velocity"] * _stat["velocity"]

func get_cooldown() -> float:
	return _base["cooldown"] * _stat["cooldown"]
	
func get_duration() -> float:
	return _base["duration"] * _stat["duration"]

func get_size() -> float:
	return _base["size"] * _stat["size"]

func get_knockback() -> float:
	return _base["knockback"] * _stat["knockback"]

func get_crit_chance() -> float:
	return _base["critical_chance"] + _stat["critical_chance"]

func get_crit_amp() -> float:
	return _base["critical_amp"] * _stat["critical_amp"]

func get_projectiles() -> int:
	return _base["projectiles"] + _stat["projectiles"]
	
func get_chain() -> int:
	return _base["chain"] + _stat["chain"]

func get_penetration() -> int:
	return _base["penetration"] + _stat["penetration"]

# 
# Defensive Stats
# 
func get_health() -> float:
	return _base["health"] * _stat["health"]

func get_shield() -> float:
	return _base["shield"] * _stat["shield"]

func get_armor() -> int:
	return _base["armor"] + _stat["armor"]

func get_regeneration() -> int:
	return _base["regeneration"] + _stat["regeneration"]

# 
# Utility
# 

func get_speed() -> float:
	return _base["speed"] * _stat["speed"]

func get_magnet() -> float:
	return _base["magnet"] * _stat["magnet"]

func get_experience() -> float:
	return _base["experience"] * _stat["experience"]

func get_avarice() -> float:
	return _base["avarice"] * _stat["avarice"]

func get_serendipity() -> float:
	return _base["serendipity"] * _stat["serendipity"]

# 
# Engine
# 

func get_spawn_base() -> int:
	return _base["spawn_base"] + _stat["spawn_base"]

func get_spawn_rate() -> float:
	return _base["spawn_rate"] + _stat["spawn_rate"]

func get_spawn_limit() -> float:
	return _base["spawn_limit"] + _stat["spawn_limit"]

func get_stat(stat: String):
	if _stat.has(stat):
		return _stat[stat]
	if _base.has(stat):
		return _base[stat]
	return null
