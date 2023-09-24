extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(on_entered)

func on_entered(area: Area2D) -> void:
	if not area is HitboxComponent:
		return
	
	area.struck.emit(self)
	
	if not health_component:
		return

	var hit = area as HitboxComponent
	health_component.damage(hit.damage, hit.critical)
