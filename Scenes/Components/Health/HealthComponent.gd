extends Node
class_name HealthComponent

var deathfx: PackedScene = preload("res://Scenes/Effects/DeathFX/DeathFX.tscn")

signal died

@export var max_health: int = 10
var current_health

func _ready() -> void:
	current_health = max_health
	if owner is Player:
		Events.emit_signal("ui_health", current_health, max_health)

func damage(amount: int, critical:bool) -> void:
	if owner is Player and Stats.base["god"] == 1:
		return
	current_health = max(current_health - amount, 0)
	if owner is Player:
		Events.emit_signal("ui_health", current_health, max_health)
	Create.floating_text(str(amount), owner.global_transform, 1, critical)
	if current_health > 0:
		flash()
	Callable(check_death).call_deferred()

func check_death() -> void:
	if current_health == 0:
		died.emit()
		if owner is Player:
			Events.emit_signal("death")
		Create.particle(deathfx, owner.global_transform)
		owner.call_deferred("queue_free")

func flash() -> void:
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(owner, "modulate", Color.RED, 0.25)
	tween.tween_property(owner, "modulate", Color.WHITE, 0.25)
