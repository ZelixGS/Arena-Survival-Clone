class_name HealthComponent extends Node

signal health_changed(type: String)
signal died

@export var max_health: int = 10
@export var default_death: bool = true
@export var flash_damage: Color = Color.RED
@export var flash_heal: Color = Color.GREEN

static var deathfx = preload("res://Scenes/Effects/DeathFX/DeathFX.tscn")

var current_health

func _ready() -> void:
	current_health = max_health
	emit_signal("health_changed")
	
func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	emit_signal("health_changed", "heal")
	flash(flash_heal)

func damage(amount: int) -> void:
	current_health = max(current_health - amount, 0)
	emit_signal("health_changed", "damage")
	if current_health > 0:
		flash(flash_damage)
	if current_health == 0:
		died.emit()
		if default_death:
			generic_death()

func generic_death() -> void:
	Create.particle(deathfx, owner.global_transform)
	call_deferred("queue_free")

func flash(flash_color: Color) -> void:
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(owner, "modulate", flash_color, 0.25)
	tween.tween_property(owner, "modulate", Color.WHITE, 0.25)
