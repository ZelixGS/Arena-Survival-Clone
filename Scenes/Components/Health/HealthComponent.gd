class_name HealthComponent extends Node

signal health_changed(current: int, max: int)
signal died

@export var max_health: int = 10
@export_group("Options")
@export var can_be_crit: bool = true
@export var drop_component: DropComponent
@export_subgroup("Flash")
@export var can_flash: bool = true
@export var flash_damage: Color = Color.RED
@export var flash_heal: Color = Color.GREEN
@export_subgroup("Extra")
@export var emit_floating_text: bool = true
@export var default_death: bool = true
@export_subgroup("Debug")
@export var god_mode: bool = false

static var deathfx = preload("res://Scenes/Effects/DeathFX/DeathFX.tscn")

var current_health: int = 0

func _ready() -> void:
	current_health = max_health
	emit_signal("health_changed")

func change_health(amount: int, crit_mod: float = 1.0 , type: G.Damage = G.Damage.PHYSICAL):
	if god_mode:
		return
	
	if not can_be_crit and crit_mod > 1:
		amount = floor(amount/crit_mod)

	if type == G.Damage.HEAL:
		heal(amount)
	else:
		damage(amount)

	emit_signal("health_changed", current_health, max_health)

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	flash(flash_heal)

func damage(amount: int) -> void:
	current_health = max(current_health - amount, 0)
	if current_health > 0:
		flash(flash_damage)
	if current_health == 0:
		died.emit()
		if drop_component:
			drop_component.drop()
		if default_death:
			generic_death()

func generic_death() -> void:
	Create.particle(deathfx, owner.global_transform)
	owner.call_deferred("queue_free")

func flash(flash_color: Color) -> void:
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(owner, "modulate", flash_color, 0.25)
	tween.tween_property(owner, "modulate", Color.WHITE, 0.25)
