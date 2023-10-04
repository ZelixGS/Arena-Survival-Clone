extends Node

const SPAWN_RADIUS: float = 400

var basic_enemy: PackedScene = preload("res://Scenes/Mobs/BasicEntity.tscn")
var placeholder_mob: EntityProperties = preload("res://Scenes/Mobs/Rat/Rat.tres")

@onready var timer: Timer = $Timer
@onready var player: Player = G.get_player()
@onready var stage: Node = get_tree().get_first_node_in_group("enemy_container")

@export var level_data: WaveData = WaveData.new()

var cached_wave = {}
var current_key: String = ""
var spawned_boss: bool = false

func _ready() -> void:
	for i in level_data.waves:
		cached_wave[i] = cache_tables(level_data.waves[i]["monsters"])

func cache_tables(input: Array) -> Dictionary:
	var total_weight: float = 0
	var cumulative: Array = []

	for i in input.size():
		total_weight += input[i][1]
		cumulative.append([input[i][0], total_weight])
	return {"weight": total_weight, "data": cumulative}

func random_from_table(input: Dictionary) -> String:
	var chance = randf_range(0, input["weight"])
	for i in input["data"]:
		if chance < i[1]:
			return i[0]
	return ""

func spawn_wave() -> void:
	var wave_key = get_wave_key()
	var wave: Dictionary = level_data.waves[wave_key]
	if wave.size() == 0:
		timer.wait_time = 1.0
		return

	var minimum: int = max(wave["minimum"] - stage.get_child_count(), 0)
	var mobs_to_spawn: int = ceil(1 * Stats.get_spawn_rate()) + minimum
	var spawn_cap: int = Stats.get_spawn_limit()
	var adjusted_count: int = min(mobs_to_spawn, spawn_cap - stage.get_child_count())

	for i in adjusted_count:
		# Randomized Spawn Position in a 360 Circle around the Player
		# Also randomize the radius by up to 10% to stagger mobs better.
		randomize()
		var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
		var random_radius: float = randf_range(SPAWN_RADIUS, SPAWN_RADIUS * 1.1)
		var spawn_position: Vector2 = player.global_position +  (random_direction * random_radius)

		var monster_data = get_monster_data(wave_key)

		var monster: Node2D = basic_enemy.instantiate()
		monster.properties = monster_data
		monster.global_position = spawn_position
		monster.rotation = 0
		stage.add_child(monster)

	timer.wait_time = wave["interval"]

func get_monster_data(input: String) -> Resource:
	var mob = random_from_table(cached_wave[input])
	if level_data.monsters.has(mob):
		return level_data.monsters[mob]
	return placeholder_mob

func get_wave_key() -> String:
	var waves: Dictionary = level_data.waves
	for i in waves.size():
		if i+1 < waves.size():
			var start_time: int = int(waves.keys()[i])
			var end_time: int = int(waves.keys()[i+1])
			if Clock.seconds > start_time and Clock.seconds <= end_time:
				return waves.keys()[i]
		else:
			return waves.keys()[i]
	return ""

func clear_enemies() -> void:
	for node in stage.get_children():
		node.call_deferred("queue_free")
	Events.emit_signal("ui_enemy_count", stage.get_child_count())

func _on_timer_timeout() -> void:
	if not player:
		return
	
	spawn_wave()
	
	Events.emit_signal("ui_enemy_count", stage.get_child_count())
