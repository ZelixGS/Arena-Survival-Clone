class_name DamageOverTime extends Node

var total_damage: int = 40
var duration_time: float = 5
var tick_rate: float = 0.5

var damage: int = 0
var health_component: HealthComponent

func _init(total: int, dur: float, rate: float) -> void:
	total_damage = total
	duration_time = dur
	tick_rate = rate
	damage = ceili(total_damage / (duration_time/tick_rate))

func _ready() -> void:
	if not get_parent() is HealthComponent:
		queue_free()
	
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
	print("tick %s" % damage)
	get_parent().damage(damage)

func _on_duration_timeout() -> void:
	finished()
	call_deferred("queue_free")

func finished() -> void:
	pass
