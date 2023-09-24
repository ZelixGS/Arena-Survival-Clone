extends Node

signal exp_gain

var character_level: int = 1
var character_level_cap: int = 200
var experience: int = 0

var levelup_effect: PackedScene = preload("res://Scenes/Effects/LevelupFX/LevelupFX.tscn")

func _ready() -> void:
	connect("exp_gain", add_experience)
	# print(get_exp_to_level(character_level))

func get_exp_to_level(level: int) -> int:
	var modifier: int = 10
	var base: int = 5
	if level > 20 and level < 40:
		modifier = 13
		base = 6
	if level > 40:
		modifier = 16
		base = 8
	return (level*modifier)-base 

func levelup() -> void:
	character_level = min(character_level + 1, 200)
	Create.particle(levelup_effect, G.get_player())
	pass

func add_experience(amount: int) -> void:
	if character_level == character_level_cap:
		return
	experience += amount
	if experience >= get_exp_to_level(character_level):
		levelup()
	
	var previous: int = max(get_exp_to_level(character_level-1), 0)
	var next: int = get_exp_to_level(character_level)
	Events.emit_signal("ui_exp", character_level, experience, previous, next)
