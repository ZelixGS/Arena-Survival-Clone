class_name HurtboxComponent extends Area2D

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(on_entered)

func on_entered(area: Area2D) -> void:
	if not area is HitboxComponent:
		return
	
	if not health_component:
		return

	var hit = area as HitboxComponent
	health_component.change_health(hit.damage, hit.crit_amp, hit.type)
	hit.emit_signal("strike", owner)
