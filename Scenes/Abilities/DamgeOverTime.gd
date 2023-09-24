extends Node
class_name DamageOverTime

var args: Dictionary = {}

@export var total_damage: float = 40
@export var duration_time: float = 5
@export var tick_rate: float = 0.5

var damage: int = 0
var health_component: HealthComponent

func _ready() -> void:
	if not health_component:
		queue_free()
	
	if args.has("total_damage"):
		total_damage = args["total_damage"]
		
	if args.has("duration_time"):
		total_damage = args["duration_time"]
		
	if args.has("tick_rate"):
		total_damage = args["tick_rate"]
		
	damage = ceili(total_damage / (duration_time/tick_rate))
	
	var tick: Timer = Timer.new()
	tick.one_shot = false
	tick.connect("timeout", _on_tick_timeout)
	add_child(tick)
	tick.start(tick_rate)
	
	var duration: Timer = Timer.new()
	duration.one_shot = true
	duration.connect("timeout", _on_duration_timeout)
	add_child(duration)
	duration.start(duration_time)

func _on_tick_timeout() -> void:
	health_component.damage(damage)

func _on_duration_timeout() -> void:
	finished()
	call_deferred("queue_free")

func finished() -> void:
	pass
