extends Resource
class_name LevelData

@export var monsters: Dictionary = {
	"rat": preload("res://Scenes/Mobs/Rat/Rat.tres"),
	"ghost": preload("res://Scenes/Mobs/Ghost/Ghost.tres")
}

@export var waves: Dictionary = {
	"0000": {"rate": 1.0, "minimum": 15, "interval": 1.0, "health": 1.0, "speed": 1.0, "scale": 1.0, "monsters": [["rat", 1.0]], "bosses": [], "events": []},
	"0060": {"rate": 1.0, "minimum": 30, "interval": 1.0, "health": 1.0, "speed": 1.0, "scale": 1.0, "monsters": [["ghost", 1.0]], "bosses": {}, "events": {}},
	"0120": {"rate": 1.0, "minimum": 45, "interval": 1.0, "health": 1.0, "speed": 1.0, "scale": 1.0, "monsters": [["wizard",1.0]], "bosses": {}, "events": {}},
}
