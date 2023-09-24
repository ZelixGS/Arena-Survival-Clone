extends Area2D
class_name Voidbox

@export var ability_name: String = ""
@export var damage = 0
@export var periodic_rate: float = 0.2
@export var size: float = 1.0

@onready var timer: Timer = $Timer

func _ready() -> void:
	$CollisionShape2D.shape.radius *= size
	timer.wait_time = periodic_rate

func _on_timer_timeout() -> void:
	for area in get_overlapping_areas():
		if area is HurtboxComponent:
			area.take_damage(damage)
