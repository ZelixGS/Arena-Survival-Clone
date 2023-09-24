extends Area2D
class_name HitboxComponent

signal struck

@export var damage = 0
@export var critical: bool = false

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		emit_signal("struck", area)
